class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Should we just put this in the app controller since we use it so frequently across all controllers?
  def current_user
    if session[:user_id] != nil
      user = User.find(session[:user_id])
    elsif session[:guest_id] != nil
      user = User.find(session[:guest_id])
    else
      user = User.new(name: "Guest", authenticated: false)
      user.save
      session[:guest_id] = user.id
    end
    return user
  end

  def find_user_purchased_products
    @user ||= User.find(session[:user_id].to_i)
    @purchase_orders = Order.where(buyer_id: @user.id).where.not(status:"pending")

    @user_products = []

    @purchase_orders.each do |order|
      @user_products += order.products
    end

    return @user_products
  end
end
