class CartController < ApplicationController
  def show
    @cart_items = (session[:cart] || []).map do |item|
      {
        product: Product.find(item['id']),
        quantity: item['quantity']
      }
    end
  end

  def add

    product_id = params[:id].to_i # Convierte el ID a entero
    Rails.logger.debug "Product ID: #{product_id}"



    begin
      product = Product.find(product_id) # Busca el producto
    rescue ActiveRecord::RecordNotFound
      redirect_to products_path, alert: "Product not found." and return
    end

    # Inicializa el carrito si aún no existe
    session[:cart] ||= []

    # Busca si el producto ya está en el carrito
    existing_item = session[:cart].find { |item| item['id'] == product.id.to_s }


    if existing_item
      # Si el producto ya está en el carrito, incrementa la cantidad
      existing_item['quantity'] += params[:quantity].to_i
    else
      # Si no está, agrega el producto al carrito
      session[:cart] << {
        'id' => product.id.to_s, # Guardar como cadena para mantener consistencia
        'name' => product.name,
        'price' => product.price,
        'quantity' => params[:quantity].to_i
      }
    end

    redirect_to cart_path, notice: "Product added to cart!"
  end


  def remove
    session[:cart].delete_if { |item| item['id'] == params[:id].to_i }
    redirect_to cart_path, notice: 'Product removed from cart!'
  end

  def clear
    session[:cart] = []
    redirect_to cart_path, notice: 'Cart cleared!'
  end
end
