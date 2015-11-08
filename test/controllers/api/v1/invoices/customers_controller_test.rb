require 'test_helper'

class Api::V1::Invoices::CustomersControllerTest < ActionController::TestCase
  test "#customer" do
    get :show, format: :json, id: Invoice.first.id
    customer = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Grape", customer[:first_name]
  end
end
