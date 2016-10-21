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
    ratings_for_seller_products = []

    user.products.each do |product|
      ratings_for_seller_products << product.rating
    end

    @seller_average_rating = ratings_for_seller_products.reduce(:+)/ratings_for_seller_products.length

    return @seller_average_rating
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :username)
    end
end
