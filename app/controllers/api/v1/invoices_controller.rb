class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with Invoice.find_by(invoice_params)
  end

  def find_all
    respond_with Invoice.where(invoice_params)
  end

  def random
    respond_with Invoice.limit(1).order("RANDOM()")
  end

  def transactions
    respond_with Invoice.find_by(invoice_params).transactions
  end

  def items
    respond_with Invoice.find_by(invoice_params).items
  end

  def customer
    respond_with Invoice.find_by(invoice_params).customer
  end

  def merchant
    respond_with Invoice.find_by(invoice_params).merchant
  end

  def merchant_invoices
    respond_with Invoice.where(merchant_id: params[:id])
  end

  def invoice_items
    respond_with Invoice.find_by(invoice_params).invoice_items
  end

  private

  def invoice_params
    params.permit(:id, :invoice_item_id, :merchant_id, :status, :created_at, :updated_at, :customer_id)
  end
end
