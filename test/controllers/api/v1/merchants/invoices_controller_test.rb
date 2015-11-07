require 'test_helper'

class Api::V1::Merchants::InvoicesControllerTest < ActionController::TestCase
  test "#invoices" do
    merchant = merchants(:two)
    get :index, merchant_id: merchant.id, format: :json
    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    assert_response :success
    assert_equal 2, invoices.count
    assert_equal "shipped", invoice[:status]
  end
end
