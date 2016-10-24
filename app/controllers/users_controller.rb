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

  def purchase_history
    @user ||= User.find(params[:id].to_i)
    @purchase_orders = Order.where(buyer_id: @user.id).where.not(status: "pending")
  end

  def selling_history
    @user ||= User.find(params[:id].to_i)
    # @sold_orders = Order.includes(Product.where(user_id: @user.id))

    #THERE MUST BE ANOTHER WAY!
    @sold_orders = []
    Order.all.each do |order|
      order.products.each do |product|
        if product.user_id == @user.id
          @sold_orders.push(order)
        end
      end
    end

  end

private
    def user_params
      params.require(:user).permit(:name, :email, :username)
    end
end
