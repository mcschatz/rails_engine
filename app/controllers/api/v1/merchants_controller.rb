class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  # before_action :authenticate!

  def index
    respond_with Merchant.all
  end

  # def show
  #   respond_with Merchant.find(params[:id])
  # end

  # def create
  #   respond_with Merchant.create(item_params)
  # end

  # def update
  #   respond_with Merchant.update(params[:id], item_params)
  # end

  # def destroy
  #   respond_with Merchant.destroy(params[:id])
  # end

  # private

  # def item_params
  #   params.require(:item).permit(:name, :description, :image_url)
  # end

  # def authenticate!
  #   authenticate_or_request_with_http_token do |token|
  #     ApiToken.exists?(token: token)
  #   end
  # end
end
