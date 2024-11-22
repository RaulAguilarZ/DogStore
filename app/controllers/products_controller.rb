class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    # Rails.logger.debug "Params received: #{params.inspect}"
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

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product successfully created.'
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :available_quantity, :category_id, :image)
  end
end