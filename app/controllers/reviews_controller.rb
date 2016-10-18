class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new

    @review.rating = params[:review][:rating]
    @review.title = params[:review][:rating]
    @review.description = params[:review][:description]

    @review.save
    
    redirect_to {controller: 'product', action:'show', id: @review.product.id }
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
