require 'test_helper'

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_invoice_items = InvoiceItem.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_invoice_items, json_response.count
  end

  test "#show" do
    invoice_item = invoice_items(:one)
    get :show, id: invoice_item.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    invoice_item = invoice_items(:one)
    get :show, id: invoice_item.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["quantity"], 10
  end
end
