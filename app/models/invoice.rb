class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

  scope :successful, -> { joins(:transactions).merge(Transaction.successful) }

  def self.pending
    joins(:transactions).merge(Transaction.unsuccessful)
  end

  def self.invoice_for_invoice_item(invoice_item_id)
    joins(:invoice_items).where(invoice_items: {id: invoice_item_id}).first
  end
end