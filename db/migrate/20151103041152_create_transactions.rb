class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at
      t.string :credit_card_expiration_date
    end
  end
end
