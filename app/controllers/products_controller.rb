class ProductsController < ApplicationController


  def show
    @product = Product.find(params[:id])
  end

  def index
     Rails.logger.debug "Params received: #{params.inspect}"
    @products = Product.includes(:category)

    # Search by Name
    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    # Filter by category
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.order(created_at: :desc).page(params[:page]).per(5)
  end

 # def create
 #   @order = Order.new(order_params)
 #   @order.user = current_user
 #   @order.total_amount = calculate_total_price
 #   @order.status = "pending"

#    if @order.save
#      # Crear los items de la orden
#      session[:cart].each do |product_id, quantity|
#        product = Product.find_by(id: product_id)
##        next unless product
 #       @order.order_items.create(product: product, quantity: quantity, price: product.price)
 #     end

      # Vaciar el carrito después de realizar el pedido
#      session[:cart] = {}
#      redirect_to order_path(@order), notice: "Tu pedido ha sido creado."
#    else
#      render :new
#    end
#  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :available_quantity, :category_id, :image)
  end
end