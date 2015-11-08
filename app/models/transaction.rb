class Transaction < ActiveRecord::Base
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :unsuccessful, -> { distinct.where(result: "failed")}

  def self.transactions_for_a_customer(customer_id)
    joins(:invoice).where(invoices: { customer_id: customer_id} )
  end
end