require 'test_helper'

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_invoices = Invoice.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_invoices, json_response.count
  end

  test "#show" do
    invoice = invoices(:one)
    get :show, id: invoice.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    invoice = invoices(:one)
    get :show, id: invoice.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["customer_id"], 113629430
  end

  test "#find" do

    get :find, format: :json, id: "113629430"

    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "shipped", invoice[:status]
    assert_equal 980190962, invoice[:merchant_id]
    assert_equal 113629430, invoice[:customer_id]
  end

  test "#find_all" do

    get :find_all, format: :json, status: "shipped"
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 4, invoices.count
    assert_equal "shipped", invoice[:status]
    assert_equal 298486374, invoice[:merchant_id]
    assert_equal 113629430, invoice[:customer_id]
  end

  test "#random" do
    get :random, format: :json
    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, invoice.count
  end

  test "#transactions" do

    get :transactions, format: :json, id: Invoice.first.id
    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    assert_response :success
    assert_equal "1111222233334444", transaction[:credit_card_number]
  end

  test "#invoice_items" do

    get :invoice_items, format: :json, id: Invoice.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal "50.0", invoice_item[:unit_price]
  end

  test "#items" do

    get :items, format: :json, id: Invoice.first.id
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Wine", item[:name]
  end

  test "#customer" do

    get :customer, format: :json, id: Invoice.first.id
    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Grape", customer[:first_name]
  end

  test "#merchant" do

    get :merchant, format: :json, id: Invoice.first.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "AWonderfulVase", merchant[:name]
  end
end
