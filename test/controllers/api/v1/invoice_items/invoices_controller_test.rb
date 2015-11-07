require 'test_helper'

class Api::V1::InvoiceItems::InvoicesControllerTest < ActionController::TestCase
    test "#invoice" do

    get :show, format: :json, id: InvoiceItem.first.id
    invoice = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 113629430, invoice[:customer_id]
  end
end