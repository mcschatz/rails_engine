class Invoice < ActiveRecord::Base
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :merchant
  belongs_to :customer

  scope :by_date, -> (date) { where(created_at: date)}
  scope :successful, -> { joins(:transactions).merge(Transaction.successful) }

  def self.pending
    joins(:transactions).merge(Transaction.unsuccessful)
  end
end