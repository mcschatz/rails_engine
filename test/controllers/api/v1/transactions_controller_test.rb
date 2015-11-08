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
    assert_equal json_response["id"], 980190962
  end

  test "#find" do
    get :find, format: :json, invoice_id: "113629430"
    transaction = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal "1111222233334444", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 113629430, transaction[:invoice_id]
  end

  test "#find_all" do
    get :find_all, format: :json, result: "success"
    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    assert_response :success
    assert_equal 3, transactions.count
    assert_equal "1111222233334444", transaction[:credit_card_number]
    assert_equal "success", transaction[:result]
    assert_equal 113629430, transaction[:invoice_id]
  end

  test "#random" do
    get :random, format: :json
    transaction = JSON.parse(response.body, symbolize_names: true)

    assert_response :success
    assert_equal 1, transaction.count
  end
end
