class OrdersController < ApplicationController

  def new

  end

  def create
    # Save the cart as a pending order if the user is signed in
    if session[:user_id] != nil
      @order = Order.find_by(buyer_id: session[:user_id], status: "pending") # If the current user already has a pending order, just add to that
      if @order.nil?
        @order = Order.new(buyer_id: session[:user_id], status: "pending") # status of the order ("pending", "paid", "complete", "cancelled")
      end

      @orderproduct = OrderProduct.find_by(order_id: @order.id, product_id: params[:order_product][:product_id])
      if @orderproduct.nil?
        @orderproduct = OrderProduct.new(order_id: @order.id, product_id: params[:order_product][:product_id], quantity: params[:order_product][:quantity])
      end

      @orderproduct.quantity = params[:order_product][:quantity]

      @order.save
      @orderproduct.save

    # Store the cart as a session variable if a user is NOT signed in
    elsif session[:cart] != nil
      session[:cart][params[:order_product][:product_id]] = params[:order_product][:quantity] # This will reset the quantity of a product if they try to add it multiple times, or make a new key for a new product
    else
      session[:cart] = {params[:order_product][:product_id] => params[:order_product][:quantity]}  # {product_id => quantity}
    end

    redirect_to :back
  end

  def index
  end

  def show
  end

  def update
    @order = Order.find(params[:id])
    @order.status = "paid"
    @order.save

  end

  def edit
    @orderproducts = [];

    # Get the products in a signed in users cart
    if session[:user_id] != nil
      @order = Order.find_by(buyer_id: session[:user_id], status: "pending") # If the current user already has a pending order, just add to that
      if @order.nil? # This would happen if they haven't added to their cart before viewing it
        @order = Order.new(buyer_id: session[:user_id], status: "pending") # status of the order ("pending", "paid", "complete", "cancelled")
      end
      @order.order_products.each do | orderproduct |
        @orderproducts << orderproduct
      end

    # Get the products in a NOT signed in users cart
    elsif session[:cart] != nil
      @order = Order.create(buyer_id: 0, status: "pending") # Making buyer ID for guest 0 by default, that way I can remove those entries later(?)

      session[:cart].each do |k, v|
        orderproduct = OrderProduct.create(order_id: @order.id, product_id: k, quantity: v)
        # orderproduct.save
        @orderproducts << orderproduct
      end
    # Make a placeholder if a not signed in user looks at an empty cart
    else
      @order = Order.create(buyer_id: 0, status: "pending")
      @orderproducts << OrderProduct.create(order_id: @order.id, product_id: 0, quantity: 0)
    end

  end

  # o.products.exists?
  # o.order_products.exists?
  # o.order_products.size
  # o.order_products.find(1)
  # o.order_products.where(shipped: nil)

  # @book = @author.books.build(published_at: Time.now,
  #                               book_number: "A12345")  # create instead of build will automatically save
  #
  # @books = @author.books.build([
  #   { published_at: Time.now, book_number: "A12346" },
  #   { published_at: Time.now, book_number: "A12347" }
  # ])

  def destroy
    # If a user is signed in
    if session[:user_id] != nil
      # Remove everything from the cart
      if params[:order_id]
        #Get all the order_products for this order
        orderproducts_to_delete = OrderProduct.where(order_id: params[:order_id])
        # If the order is pending
        if Order.find_by(id: params[:order_id]).status == "pending"  # just in case, probably not necessary
          # Delete them
          orderproducts_to_delete.each do | orderproduct |
            orderproduct.destroy
          end
        end
      # OR just remove one thing from the cart
      elsif params[:id]
        orderproduct = OrderProduct.find_by(product_id: params[:id])
        orderproduct.destroy
      end

    # If a user is NOT signed in
    elsif session[:cart] != nil
      if params[:order_id]
        # session[:cart] = nil
      elsif params[:id]
        session[:cart].delete(params[:id])
      end
    end
    redirect_to(:back)
  end
end
