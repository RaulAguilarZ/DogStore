class CartsController < ApplicationController
  require 'ostruct'
  before_action :authenticate_user!, only: [:create_order]
  before_action :initialize_cart

    def show
      session[:cart] ||= {}

      @cart_items = session[:cart].map do |product_id, quantity|
        product = Product.find_by(id: product_id)
        next unless product
        { product: product, quantity: quantity }
      end.compact

      @total_price = @cart_items.sum { |item| item[:product].price * item[:quantity] }

      @order = current_user.orders.last if current_user
    end

    def add
      session[:cart] ||= {}
      product_id = params[:id].to_i
      quantity = params[:quantity].to_i

      product = Product.find_by(id: product_id)

      if product
        session[:cart][product_id] = session[:cart].fetch(product_id, 0) + quantity
        redirect_back fallback_location: products_path, notice: "Product added to cart."
      else
        redirect_back fallback_location: products_path, alert: "Product not found."
      end
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

    def create_order
      if current_user.nil?
        redirect_to new_user_session_path, alert: "Debes iniciar sesión para realizar la compra."
        return
      end

      cart_items = current_cart_items
      total_amount = Order.new.calculate_total(cart_items)

      if total_amount <= 0
        redirect_to cart_path, alert: "El carrito está vacío o no tiene productos válidos."
        return
      end

      @order = current_user.orders.new(
        status: 'pending',
        total_amount: total_amount
      )

      if @order.save

        # Crear los elementos de la orden
        cart_items.each do |cart_item|
          @order.order_items.create!(
            product: cart_item.product,
            quantity: cart_item.quantity,
            price: cart_item.product.price
          )
        end

        session[:cart] = {}
        redirect_to order_path(@order), notice: "La orden ha sido creada exitosamente."
      else
        redirect_to cart_path, alert: "Hubo un error al crear la orden: #{@order.errors.full_messages.to_sentence}."
      end
    end

    private
    def initialize_cart
      session[:cart] ||= {}
    end

    def current_cart_items
      product_ids = session[:cart].keys.map(&:to_i)
      products = Product.where(id: product_ids).index_by(&:id)

      session[:cart].map do |product_id, quantity|
      product = products[product_id.to_i]

        if product
          OpenStruct.new(product: product, quantity: quantity)
        else
          nil
        end
      end.compact  # Compact to remove any nil value in the resulting array
    end

    def calculate_total_price
      current_cart_items.sum do |item|
        if item.product.present?
          item.product.price.to_f * item.quantity
        else
          0
        end
      end
    end
  end