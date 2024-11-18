class CheckoutController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @cart_items = @cart.map do |product_id, quantity|
      product = Product.find(product_id)
      { product: product, quantity: quantity }
    end
    @total = @cart_items.sum { |item| item[:product].price * item[:quantity] }
  end

  def create

  end
end
