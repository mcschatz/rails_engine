require 'test_helper'

class Api::V1::Invoices::ItemsControllerTest < ActionController::TestCase
  test "#items" do
    get :index, format: :json, invoice_id: Invoice.first.id
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal "Wine", item[:name]
  end
end