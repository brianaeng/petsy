class ProductsController < ApplicationController
  def product
    @product ||= Product.find(params[:id].to_i)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to request.referrer #Where
    else
      #Where do we want this to go?
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id].to_i)
    @reviews = Review.where(product_id: params[:id].to_i)
  end

  def update
    product.update_attributes(product_params)
    redirect_to request.referrer
  end

  def edit
    product
  end

  def destroy
    product.destroy
    redirect_to #Where?
  end

private
   def product_params
     params.require(:product).permit(:name, :user_id, :price, :quantity, :exotic, :farm, :domestic, :description, :picture)
   end
end
