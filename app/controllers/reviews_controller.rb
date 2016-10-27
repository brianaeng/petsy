class ReviewsController < ApplicationController
  def new
    # @user ||= User.find(session[:user_id].to_i)
    # @purchase_orders = Order.where(buyer_id: @user.id).where.not(status:"pending")
    #
    # @user_products = []
    #
    # @purchase_orders.each do |order|
    #   @user_products += order.products
    # end
    find_user_purchased_products

    if @user_products.include? (Product.find(params[:product_id]))
      @review = Review.new
    else
      redirect_to product_path(params[:product_id])
    end

  end

  def create
    @review = Review.new

    @review.rating = params[:review][:rating]
    @review.title = params[:review][:title]
    @review.description = params[:review][:description]
    @review.product_id = params[:product_id]

    if @review.save
      redirect_to product_path(@review.product_id)
    else
      flash[:notice] = @review.errors.full_messages
      redirect_to product_reviews_new_path
    end

  end

  # def index
  # end

  # def show
  # end

  # def update
  # end

  # def edit
  # end

  # def destroy
  # end

end
