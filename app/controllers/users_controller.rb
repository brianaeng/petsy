class UsersController < ApplicationController
  def user
    @user ||= User.find(params[:id].to_i)
  end

  def new
    @user = User.new
  end

  def create

  end

  # def index
  # end

  def show
    user
    @products = Product.where(user_id: @user.id )
  end

  def edit
    user
  end

  def update
    user.update_attributes(user_params)
    redirect_to user_path(user.id)
  end

  def destroy
    user.destroy
    redirect_to root_path
  end

  def seller_average_rating
    #Find all of the products sold by this seller
    @products = user.products
    #Find all of the reveiws for all of the products sold by this seller
    @reviews = []
    @products.each do |product|
      @reviews << Review.where(product_id: product.id)
    end
    #Find all of the ratings for all of those reviews
    @ratings = []
    @reviews.each do |review|
      @ratings << review.rating
    end
    #Sum all of the ratings and divide the sum by the number of ratings
    @average_rating = @ratings.reduce(:+)/@ratings.length

    return @average_rating
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :username)
    end
end
