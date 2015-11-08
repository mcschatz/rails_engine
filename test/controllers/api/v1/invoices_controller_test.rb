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
end
