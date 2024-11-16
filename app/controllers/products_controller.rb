class ProductsController < ApplicationController


  def index

    @products = Product.all

    if params[:filter] == 'on_sale'
      @products = @products.on_sale
    elsif params[:filter] == 'new'
      @products = @products.new_products
    elsif params[:filter] == 'recently_updated'
      @products = @products.recently_updated
    end

    # Clave word
    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    # Filter Category
    # if params[:category].present?
    #  @products = @products.where(category: params[:category])
    # end

    @products = @products.order(created_at: :desc).page(params[:page]).per(10)

  end

end