class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  before_save :convert_unit_price

  default_scope {order(:id)}

  def convert_unit_price
    self.unit_price = self.unit_price/100
  end

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(:invoice_items)
      .group("items.id")
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.most_items(quantity)
    select("items.*, count(invoice_items.quantity) as item_count")
      .joins(:invoice_items)
      .group("items.id")
      .order("item_count DESC")
      .limit(quantity)
  end

  def best_day
    invoice_items.successful
                 .group("invoices.created_at")
                 .order("sum_quantity DESC")
                 .sum("quantity")
                 .first[0]
  end
end