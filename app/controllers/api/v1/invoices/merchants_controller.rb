class Api::V1::Invoices::MerchantsController < Api::V1::MerchantsController
  def show
    respond_with Merchant.invoices(params[:id])
  end
end