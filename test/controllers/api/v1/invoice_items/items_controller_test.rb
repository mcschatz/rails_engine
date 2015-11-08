require 'test_helper'

class Api::V1::InvoiceItems::ItemsControllerTest < ActionController::TestCase
  test "#item" do
    get :show, format: :json, id: InvoiceItem.first.id
    item = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "Coffee", item[:name]
  end
end