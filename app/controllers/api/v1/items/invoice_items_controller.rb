class Api::V1::Items::InvoiceItemsController < Api::V1::InvoiceItemsController
  def index
    respond_with InvoiceItem.where(item_id: params[:item_id])
  end
end