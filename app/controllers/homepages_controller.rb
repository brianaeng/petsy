class HomepagesController < ApplicationController

  def index
    get_current_user

    @q = Product.ransack(params[:q])
    @results = @q.result(distinct: true)

    #need to get product's average review rating then order with .order('rating DESC') and take first one from each category
    @random_pet1 =  Product.find(rand(Product.count))
    @random_pet2 =  Product.find(rand(Product.count))
    @random_pet3 =  Product.find(rand(Product.count))

  end

  def show
  end

  private
  def get_current_user # Private Helper method
    @user = User.find_by(id: session[:user_id]) # It will figure out the integer thing and return nil if it doesn't find anything
  end

end
