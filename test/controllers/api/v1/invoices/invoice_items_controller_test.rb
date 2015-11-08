require 'test_helper'

class Api::V1::Invoices::InvoiceItemsControllerTest < ActionController::TestCase
  test "#invoice_items" do
    get :index, format: :json, invoice_id: Invoice.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal "50.0", invoice_item[:unit_price]
  end
end