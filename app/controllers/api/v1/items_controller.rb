class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(item_params)
  end

  def find_all
    respond_with Item.where(item_params)
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  def invoice_items
    respond_with Item.find_by(item_params).invoice_items
  end

  def merchant
    respond_with Item.find_by(item_params).merchant
  end

  def most_revenue
    respond_with Item.unscoped.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Item.unscoped.most_items(params[:quantity])
  end

  def best_day
    respond_with best_day: Item.find(params[:id]).best_day
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :quantity)
  end
end
