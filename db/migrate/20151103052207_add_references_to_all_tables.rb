class AddReferencesToAllTables < ActiveRecord::Migration
  def change
    add_reference :invoices, :customer, index: true
    add_reference :invoices, :merchant, index: true
    add_reference :invoice_items, :item, index: true
    add_reference :invoice_items, :invoice, index: true
    add_reference :transactions, :invoice, index: true
    add_reference :items, :merchant, index: true
  end
end
