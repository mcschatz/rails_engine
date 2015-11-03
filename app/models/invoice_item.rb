class InvoiceItems < AcitveRecord::Base
  belongs_to :item
  belongs_to :invoice
end