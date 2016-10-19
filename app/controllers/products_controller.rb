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
      user_show_path
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

  # def average_rating_for_this_product
  #     @reviews = Review.where(product_id: params[:id].to_i)
  #     @reviews.rating.reduce()
  # end
  # def seller_average_rating
  #   ratings_for_products_from_this_seller = []
  #   @product = Product.find(params[:id].to_i)
  #   #Find all the products that the seller of this product also sells
  #   @products = Product.where(user_id: @product.user_id)
  #   @products.each do |product|
  #
  #
  # end
private
   def product_params
     params.require(:product).permit(:name, :user_id, :price, :quantity, :exotic, :farm, :domestic, :description, :picture)
   end
end
