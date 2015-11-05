class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.most_revenue(params)
    if params[:quantity] == "x"
      self.all.sort_by { |merchant| merchant.revenue }.reverse
    else
      quantity = params[:quantity].to_i - 1
      self.all.sort_by { |merchant| merchant.revenue }.reverse[0..quantity]
    end
  end

  def revenue(date = nil)
    if date.nil?
      invoices.successful
              .joins(:invoice_items)
              .sum('quantity * unit_price')
    else
      invoices.successful
              .where(invoices: { created_at: date })
              .joins(:invoice_items)
              .sum('quantity * unit_price')
    end
  end

  def self.most_items(params)
    if params[:quantity] == "x"
      self.all.sort_by { |merchant| merchant.single_items }.reverse
    else
      quantity = params[:quantity].to_i - 1
      self.all.sort_by { |merchant| merchant.single_items }.reverse[0..quantity]
    end
  end

  def single_items
    invoices.successful
            .joins(:invoice_items)
            .sum('quantity')
  end

  def self.total_revenue(date)
    date = nil if date == "x"
    total = self.all.map { |merchant| merchant.revenue(date) }.sum
    { :total_revenue => total.round(2) }
  end

  def single_revenue(date)
    date = nil if date == "x"
    { :revenue => self.revenue(date).round(2) }
  end

  def favorite_customer
    customers.select("customers.*, count(invoices.customer_id) AS invoice_count")
             .joins(invoices: :transactions)
             .merge(Transaction.successful)
             .group("customers.id")
             .order("invoice_count DESC")
             .first
  end

  def pending_invoices
    invoices.pending.map(&:customer).uniq
  end
end