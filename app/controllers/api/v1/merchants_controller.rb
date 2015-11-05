class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def items
    respond_with Merchant.find_by(merchant_params).items
  end

  def invoices
    respond_with Merchant.find_by(merchant_params).invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(merchant_params)
  end

  def most_items
    respond_with Merchant.most_items(merchant_params)
  end

  def revenue
    if params[:id]
      respond_with Merchant.find(params[:id]).single_revenue(params[:date])
    else
      respond_with Merchant.total_revenue(params[:date])
    end
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(params[:id]).pending_invoices
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at, :quantity, :date)
  end
end
