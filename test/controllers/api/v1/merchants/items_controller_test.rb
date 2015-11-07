require 'test_helper'

class Api::V1::Merchants::ItemsControllerTest < ActionController::TestCase
  test "#items" do
    merchant = merchants(:one)
    get :index, merchant_id: merchant.id, format: :json
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    assert_response :success
    assert_equal 1, items.count
    assert_equal "Wine", item[:name]
    assert_equal "pinot noir", item[:description]
  end
end
