class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with find_merchant
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
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def revenue
    respond_with revenue: find_merchant.revenue(params[:date])
  end

  def total_revenue
    respond_with total_revenue: Merchant.total_revenue(params[:date])
  end

  def favorite_customer
    respond_with find_merchant.favorite_customer
  end

  def customers_with_pending_invoices
    respond_with find_merchant.pending_invoices
  end

  private

  def find_merchant
    Merchant.find(params[:id])
  end

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at, :quantity, :date)
  end
end
