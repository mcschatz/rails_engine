require 'test_helper'

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_merchants = Merchant.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_merchants, json_response.count
  end

  test "#show" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    merchant = merchants(:one)
    get :show, id: merchant.id, format: :json

    json_response = JSON.parse(response.body)

    assert_equal json_response["name"], "AWonderfulVase"
  end
end
