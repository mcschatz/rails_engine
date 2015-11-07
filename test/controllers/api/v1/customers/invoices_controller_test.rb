require 'test_helper'

class Api::V1::Customers::InvoicesControllerTest < ActionController::TestCase
  test "#invoices" do

    get :index, format: :json, customer_id: Customer.last.id
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 980190962, invoice[:customer_id]
  end
end
