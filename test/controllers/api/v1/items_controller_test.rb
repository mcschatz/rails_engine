require 'test_helper'

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_items = Item.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_items, json_response.count
  end

  test "#show" do
    item = items(:one)
    get :show, id: item.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    item = items(:one)
    get :show, id: item.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["merchant_id"], 298486374
  end

  test "#find" do

    get :find, format: :json, name: "Wine"

    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Wine", item[:name]
    assert_equal "pinot noir", item[:description]
    assert_equal "15.13", item[:unit_price]
    assert_equal 980190962, item[:merchant_id]
  end

  test "#find_all" do

    get :find_all, format: :json, description: "dark"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Chocolate", item[:name]
    assert_equal "dark", item[:description]
    assert_equal "20.76", item[:unit_price]
    assert_equal 298486374, item[:merchant_id]
  end

  test "#random" do
    get :random, format: :json
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, item.count
  end

  test "#invoice_items" do

    get :invoice_items, format: :json, id: Item.first.id
    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    assert_response :success
    assert_equal 980190962, invoice_item[:id]

  end

  test "#merchant" do

    get :merchant, format: :json, id: Item.last.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "BowWowWow", merchant[:name]

  end

  test "#most_revenue" do

    get :most_revenue, format: :json, quantity: "2"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 2, items.count
    assert_equal "Wine", item[:name]
  end

  test "#most_items" do

    get :most_items, format: :json, quantity: "1"
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Coffee", item[:name]
    assert_equal "java", item[:description]
  end

  test "#best_day" do

    get :best_day, format: :json, id: Item.last.id
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "2013-03-13T06:54:11.000Z", item[:best_day]
  end
end
