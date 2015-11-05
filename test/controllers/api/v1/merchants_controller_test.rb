require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_merchants = Merchant.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_merchants, json_response.count
  end

  test "#show" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["name"], "AWonderfulVase"
  end

  test "#find" do
    get :find, format: :json, name: "BowWowWow"
    merchants = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "BowWowWow", merchants[:name]
    assert_equal 4, merchants.count
  end

  test "#find_all" do
    get :find_all, format: :json, name: "BowWowWow"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal "BowWowWow", merchant[:name]
    assert_equal 2, merchants.count
  end

  test "#random" do

    get :random, format: :json
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, merchant.count
  end

  test "#items" do
    merchant = merchants(:one)
    get :items, id: merchant.id, format: :json
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 1, items.count
    assert_equal "Wine", item[:name]
    assert_equal "pinot noir", item[:description]
  end

  test "#invoices" do
    merchant = merchants(:two)
    get :invoices, id: merchant.id, format: :json
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 2, invoices.count
    assert_equal "shipped", invoice[:status]
  end

  test "#most_revenue" do
    get :most_revenue, format: :json, quantity: "2"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 2, merchants.count
    assert_equal "AWonderfulVase", merchant[:name]
  end

  test "#most_items" do
    get :most_items, format: :json, quantity: "1"
    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    assert_response :success
    assert_equal 1, merchants.count
    assert_equal "AWonderfulVase", merchant[:name]
  end

  test "#total revenue" do
    get :revenue, format: :json
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "1650.0", revenue[:total_revenue]
  end

  test "#total revenue with date" do
    get :revenue, format: :json, date: "2013-03-13T06:54:11.000Z"
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "1650.0", revenue[:total_revenue]
  end

  test "#revenue for single merchant" do
    get :revenue, format: :json, id: Merchant.last.id
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "1650.0", revenue[:revenue]
  end

  test "#revenue for single merchant with date" do
    get :revenue, format: :json, id: Merchant.second.id, date: "2013-03-13T06:54:11.000Z"
    revenue = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "0.0", revenue[:revenue]
  end

  test "#favorite_customer" do
    get :favorite_customer, format: :json, id: Merchant.last.id
    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Grape", customer[:first_name]
  end

  test "#customers_with_pending_invoices" do
    get :customers_with_pending_invoices, format: :json, id: Merchant.last.id
    customers = JSON.parse(response.body, symbolize_names: true)
    customer = customers.first
    assert_response :success
    assert_equal "Grape", customer[:first_name]
  end
end
