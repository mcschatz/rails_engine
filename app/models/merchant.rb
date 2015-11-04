class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.most_revenue(params)
    quantity = params[:quantity].to_i - 1
    self.all.sort_by { |merchant| merchant.revenue }.reverse[0..quantity]
  end

  def revenue(date = nil)
    if date.nil?
      invoices.successful.joins(:invoice_items).sum('quantity * unit_price')
    else
      invoices.successful.where(invoices: { created_at: date })
          .joins(:invoice_items).sum('quantity * unit_price')
    end
  end
end