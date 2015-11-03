require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_transactions = Transaction.count
    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_transactions, json_response.count
  end

  test "#show" do
    transaction = transactions(:one)
    get :show, id: transaction.id, format: :json

    assert_response :success
  end

  test "#show returns the right object name" do
    transaction = transactions(:one)
    get :show, id: transaction.id, format: :json

    json_response = JSON.parse(response.body)
    assert_equal json_response["invoice_id"], 1
  end
end
