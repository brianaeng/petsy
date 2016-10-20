class UsersController < ApplicationController
  # before_action :find_user only: [:show, :edit, :update]
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
  end

  private  # Limited to just this class
    def user_params
      params.require(:user).permit(:name, :email, :username)
    end
  # def student_params  # This is for security --> it will pull everything for :student key and only permit people to use the keys :first_name and :last_name
  #   params.require(:user).permit(:name)
  # end

  # def find_user
  #   @user = User.find(params[:id])
  # end
end
