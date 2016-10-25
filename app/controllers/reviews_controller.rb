class ReviewsController < ApplicationController
  def new
    #ADD RESTRICTION SO ONLY USERS WHO BOUGHT ITEM CAN REVIEW?
    #Not sure if the below works yet, need to make a purchase and then check if I can review
    @user ||= User.find(session[:user_id].to_i)
    @purchase_orders = Order.where(buyer_id: @user.id)#.not.where(status:"pending")

    @purchase_orders.each do |order|
      order.products.each do |product|
        if product.id == params[:product_id]
          @review = Review.new
        end
      end
    end

    # redirect_to product_path(params[:product_id])
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
