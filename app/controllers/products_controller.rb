class ProductsController < ApplicationController
  def product
    @product ||= Product.find(params[:id].to_i)
  end

  def new
    @product = Product.new
    # @categories = @product.categories.build
  end

  def create
    @product = Product.new(product_params)

    # @categories = Category.all
    #
    # params[:categories].each do |cat|
    #   @product.categories << Category.find_by_name(cat)
    # end

    if @product.save
      redirect_to action: "show", id: @product.id
    else
      user_show_path
    end
  end

  def index
    if params[:commit] == "search"
      if !params[:q].blank?
        @results = Product.ransack(params[:q])
      else
        @results = Product.ransack({:id_eq => 0})
      end

      @products = @results.result

    else
      @products = Product.all
    end
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
    redirect_to user_path(product.user_id)
  end

  def average_rating_for_this_product
      @reviews = Review.where(product_id: params[:id].to_i)
      ratings = []
      @reviews.each do |review|
        ratings << review.rating
      end
      average_product_rating = ratings.reduce(:+)/ratings.length
      return average_product_rating
  end

private
   def product_params
     params.require(:product).permit(:name, :user_id, :price, :quantity, :description, :picture, :active, category_ids: [])
   end
end
