require 'test_helper'

class Api::V1::Items::InvoiceItemsControllerTest < ActionController::TestCase
  test "#invoice_items" do
    get :index, format: :json, item_id: Item.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 980190962, invoice_item[:id]

  end
end
