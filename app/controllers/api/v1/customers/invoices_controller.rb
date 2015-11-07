class Api::V1::Customers::InvoicesController < Api::V1::InvoicesController
  def index
    respond_with Invoice.where(customer_id: params[:customer_id])
  end
end