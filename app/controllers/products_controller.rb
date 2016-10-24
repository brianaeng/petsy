class ProductsController < ApplicationController
  def product
    @product ||= Product.find(params[:id].to_i)
  end

  def new
    @product = Product.new
    @product.categories.build
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      if Category.find_by(name:"") != nil #swap this to .exists?
        blank = Category.find_by(name:"")
        blank.destroy
      end
      redirect_to action: "show", id: @product.id
    else
      redirect_to new_product_path
    end
  end

  def index
    @categories = Category.all
    if params[:commit] == "search"
      if !params[:q].blank?
        @results = Product.ransack(params[:q])
      else
        @results = Product.ransack({:id_eq => 0})
      end

      @products = @results.result

    elsif !params[:category_id].blank?
      @products = Category.find(params[:category_id]).products
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id].to_i)
    @reviews = Review.where(product_id: params[:id].to_i)

    if session[:user_id] != nil
      @order = Order.find_by(buyer_id: session[:user_id], status: "pending") # If the current user already has a pending order, just add to that
      if @order.nil?
        @order = Order.new(buyer_id: session[:user_id])
      end
      @orderproduct = OrderProduct.new(order_id: @order.id, product_id: @product.id, quantity: 0)  #this isn't really necessary, but this gives the quantity field in the form
    else
      @orderproduct = OrderProduct.new(order_id: 0, product_id: @product.id, quantity: 0)
    end
  end

  def update
    product
    @product.update(product_params)

    if Category.find_by(name:"") != nil
      blank = Category.find_by(name:"")
      blank.destroy
    end

    redirect_to action: "show", id: @product.id
  end

  def edit
    product

    if session[:user_id] == @product.user_id
      @product.categories.build
    else
      redirect_to root_path
    end
  end

  def destroy
    product.destroy
    redirect_to user_path(product.user_id)
  end

  def activation
    product.update_attribute(product.toggle :active)
    redirect_to(request.referer)
  end


private
   def product_params
     params.require(:product).permit(:name, :user_id, :price, :quantity, :description, :picture, :active, categories_attributes: [:name], category_ids: [])
   end
end
