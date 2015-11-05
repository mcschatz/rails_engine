require 'test_helper'

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_customers = Customer.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_customers, json_response.count
  end

  test "#show" do
    customer = customers(:one)
    get :show, id: customer.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    customer = customers(:one)
    get :show, id: customer.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["first_name"], "Johnny"
  end

  test "#find" do

    get :find, format: :json, last_name: "Cash"

    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Johnny", customer[:first_name]
    assert_equal "Cash", customer[:last_name]
  end

  test "#find_all" do

    get :find_all, format: :json, first_name: "Grape"
    customers = JSON.parse(response.body, symbolize_names: true)
    customer = customers.first

    assert_response :success
    assert_equal "Grape", customer[:first_name]
    assert_equal "Nuts", customer[:last_name]
  end

  test "#random" do
    get :random, format: :json
    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, customer.count
  end

  test "#invoices" do

    get :invoices, format: :json, id: Customer.last.id
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 980190962, invoice[:customer_id]
  end

  test "#transactions" do

    get :transactions, format: :json, id: Customer.first.id
    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    assert_response :success
    assert_equal "1111222233334444", transaction[:credit_card_number]
  end

  test "#favorite_merchant" do

    get :favorite_merchant, format: :json, id: Customer.last.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "AWonderfulVase", merchant[:name]
  end
end
