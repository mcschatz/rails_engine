class Api::V1::Customers::TransactionsController < Api::V1::TransactionsController
  def index
    respond_with Transaction.transactions_for_a_customer(params[:customer_id])
  end
end