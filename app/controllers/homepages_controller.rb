class HomepagesController < ApplicationController

  def index
    get_current_user

    @q = Product.ransack(params[:q])
    @results = @q.result(distinct: true)

    #need to get product's average review rating then order with .order('rating DESC') and take first one from each category
    three_random_images
  end

  def show
    get_current_user
  end


private
  def get_current_user # Private Helper method
    @user = User.find_by(id: session[:user_id]) # It will figure out the integer thing and return nil if it doesn't find anything
  end

  def three_random_images
    @unique_random_nums = []
    until @unique_random_nums.length == 3
      @unique_random_nums << (1 + rand(Product.count))
      @unique_random_nums.uniq!
    end

    @random_pet1 =  Product.find(@unique_random_nums[0])
    @random_pet2 =  Product.find(@unique_random_nums[1])
    @random_pet3 =  Product.find(@unique_random_nums[2])
  end
end
