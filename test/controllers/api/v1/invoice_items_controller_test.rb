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

  test "#find" do
    get :find, format: :json, quantity: "2"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 2, invoice_item[:quantity]
    assert_equal "25.0", invoice_item[:unit_price]
    assert_equal 980190962, invoice_item[:item_id]
    assert_equal 113629430, invoice_item[:invoice_id]
  end

  test "#find_all" do
    get :find_all, format: :json, unit_price: "25.0"
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 2, invoice_item[:quantity]
    assert_equal "25.0", invoice_item[:unit_price]
    assert_equal 980190962, invoice_item[:item_id]
    assert_equal 113629430, invoice_item[:invoice_id]
  end

  test "#random" do
    get :random, format: :json
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, invoice_item.count
  end
end
