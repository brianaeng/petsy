class UsersController < ApplicationController
  before_action :find_user only: [:show, :edit, :update]

  def new
  end

  def create
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private  # Limited to just this class

  # def student_params  # This is for security --> it will pull everything for :student key and only permit people to use the keys :first_name and :last_name
  #   params.require(:user).permit(:name)
  # end

  def find_user
    @user = User.find(params[:id])
  end
end
