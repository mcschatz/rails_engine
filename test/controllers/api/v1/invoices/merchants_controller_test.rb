require 'test_helper'

class Api::V1::Invoices::MerchantsControllerTest < ActionController::TestCase
  test "#merchant" do
    get :show, format: :json, id: Invoice.first.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "AWonderfulVase", merchant[:name]
  end
end