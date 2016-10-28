class HomepagesController < ApplicationController

  def index
    @user = current_user

    @q = Product.ransack(params[:q])
    # @products = @q.result(distinct: true)

    random_images
  end


private
  # def get_current_user # Private Helper method
  #   @user = User.find_by(id: session[:user_id]) # It will figure out the integer thing and return nil if it doesn't find anything
  # end

  def random_images
    @products = Product.all
    @chosen_pets = @products.sample(6)
  end

  # current_user in ApplicationController now

end
