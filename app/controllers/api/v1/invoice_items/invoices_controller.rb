class Api::V1::InvoiceItems::InvoicesController < Api::V1::InvoicesController
  def show
    respond_with Invoice.invoice_for_invoice_item(params[:id])
  end
end