class Api::V1::Transactions::InvoicesController < Api::V1::InvoicesController
  def show
    respond_with Invoice.invoice_for_transaction(params[:id])
  end
end