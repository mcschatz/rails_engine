class Transaction < ActiveRecord::Base
  belongs_to :invoice

  scope :successful, -> { where(result: "success") }
  scope :unsuccessful, -> { distinct.where(result: "failed")}
end