class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.most_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(:invoice_items)
      .merge(InvoiceItem.successful)
      .group("merchants.id")
      .order("revenue DESC")
      .limit(quantity)
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

  def self.total_revenue(date)
    select("merchants.*")
      .joins(invoices: :invoice_items)
      .merge(InvoiceItem.successful)
      .where(invoices: { created_at: date })
      .sum('quantity * unit_price')
  end

  def self.most_items(quantity)
    select("merchants.*, sum(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("item_count DESC")
      .merge(InvoiceItem.successful)
      .limit(quantity)
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

  def self.items(id)
    joins(:items).where(items: { id: id }).first
  end
end