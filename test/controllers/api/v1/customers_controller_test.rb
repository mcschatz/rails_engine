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
end
