require 'test_helper'

class Api::V1::Invoices::TransactionsControllerTest < ActionController::TestCase
test "#transactions" do
    get :index, format: :json, invoice_id: Invoice.first.id
    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    assert_response :success
    assert_equal "1111222233334444", transaction[:credit_card_number]
  end
end
