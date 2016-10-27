class HomepagesController < ApplicationController

  def index
    get_current_user

    @q = Product.ransack(params[:q])
    # @products = @q.result(distinct: true)

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

    # @unique_random_nums = []
    # until @unique_random_nums.length == 3
    #   @unique_random_nums << (1 + rand(Product.count))
    #   @unique_random_nums.uniq!
    # end
    # #this was trying to find products that don't exist (destroyed or something?)
    # @random_pet1 =  Product.find(@unique_random_nums[0])
    # @random_pet2 =  Product.find(@unique_random_nums[1])
    # @random_pet3 =  Product.find(@unique_random_nums[2])

    #another possible solution?
    @products = Product.all
    @chosen_pets = @products.sample(8)
    # @random_pet1 = @chosen_pets[0]
    # @random_pet2 = @chosen_pets[1]
    # @random_pet3 = @chosen_pets[2]
  end

end
