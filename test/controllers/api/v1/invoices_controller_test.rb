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
    assert_equal json_response["customer_id"], 1
  end
end
