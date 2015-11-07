class Api::V1::Items::MerchantsController < Api::V1::MerchantsController
  def show
    respond_with Merchant.items(params[:id])
  end
end