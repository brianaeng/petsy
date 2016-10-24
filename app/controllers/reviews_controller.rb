class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new

    @review.rating = params[:review][:rating]
    @review.title = params[:review][:rating]
    @review.description = params[:review][:description]
    @review.product_id = params[:product_id]

    #need to call flash[:notice] in views
    if @review.save
      flash[:notice] = "Review successfully created"
      redirect_to product_path(@review.product_id)
    else
      @notices = @review.errors.full_messages.join("\n")
      flash[:notice] = @notices
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
