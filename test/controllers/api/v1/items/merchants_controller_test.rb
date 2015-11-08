require 'test_helper'

class Api::V1::Items::MerchantsControllerTest < ActionController::TestCase
  test "#merchant" do
    get :show, format: :json, id: Item.last.id
    merchant = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "BowWowWow", merchant[:name]

  end
end