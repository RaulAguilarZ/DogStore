class CartsController < ApplicationController
    before_action :initialize_cart

    def show
     # @cart = session[:cart] || {}
     # @cart_items = session[:cart].map do |product_id, quantity|
     #   product = Product.find(product_id)
     #   { product: product, quantity: quantity }
     # end
     session[:cart] ||= {}
     @cart_items = session[:cart].map do |product_id, quantity|
       product = Product.find_by(id: product_id)
       next unless product

       { product: product, quantity: quantity }
     end.compact

    end

    def add
      #product_id = params[:product_id].to_i
      #session[:cart][product_id] ||= 0
      #session[:cart][product_id] += 1
      #redirect_back fallback_location: products_path, notice: "Product added to cart."


      session[:cart] ||= {}
      product_id = params[:id].to_i
      quantity = params[:quantity].to_i

      if session[:cart][product_id]
        session[:cart][product_id] += quantity
      else
        session[:cart][product_id] = quantity
      end

      redirect_back fallback_location: products_path, notice: "Product added to cart."

    end

    def remove
      session[:cart] ||= {}
      product_id = params[:id].to_s
      if session[:cart][product_id]
        session[:cart].delete(product_id)
        redirect_to cart_path, notice: 'Product removed from the cart.'
      else
        redirect_to cart_path, alert: 'Product not found in the cart.'
      end
    end

    def clear
      session[:cart] = {}
      redirect_to cart_path, notice: "Empty cart."
    end


    def update_quantity
      product_id = params[:product_id]
      new_quantity = params[:quantity].to_i

      session[:cart] ||= {}

      if session[:cart][product_id]
        if new_quantity > 0
          session[:cart][product_id] = new_quantity
          redirect_to cart_path, notice: 'Quantity updated.'
        else
          session[:cart].delete(product_id)
          redirect_to cart_path, notice: 'Product removed from cart.'
        end
      else
        redirect_to cart_path, alert: 'Product not found in cart.'
      end
    end


    private

    def initialize_cart
      session[:cart] ||= {}
    end
  end