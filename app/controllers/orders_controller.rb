class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  flash[:alert] = "Order not found."
  redirect_to orders_path
  end

  private

  def calculate_total_price
    total = 0
    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      total += product.price * quantity
    end
    total
  end
end
