class Api::V1::InvoiceItems::ItemsController < Api::V1::ItemsController
  def show
    respond_with Item.item_for_invoice_item(params[:invoice_item_id])
  end
end