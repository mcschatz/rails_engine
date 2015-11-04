class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

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
      invoices.successful.joins(:invoice_items).sum('quantity * unit_price')
    else
      invoices.successful.where(invoices: { created_at: date })
          .joins(:invoice_items).sum('quantity * unit_price')
    end
  end

  def self.most_items(params)
    if params[:quantity] == "x"
      self.all.sort_by { |merchant| merchant.items }.reverse
    else
      quantity = params[:quantity].to_i - 1
      self.all.sort_by { |merchant| merchant.items }.reverse[0..quantity]
    end
  end

  def items
    invoices.successful.joins(:invoice_items).sum('quantity')
  end

  def self.total_revenue(date)
    date = nil if date == "x"
    total = self.all.map { |merchant| merchant.revenue(date) }.sum
    { :total_revenue => total.round(2) }
  end

  def single_revenue(date)
    date = nil if date == "x"
    total = self.revenue(date)
    { :revenue => total.round(2) }
  end
end