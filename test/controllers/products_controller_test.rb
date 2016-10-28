require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def create_authenticated_user
   @walter = User.create(name: "Walter", email: "Walt@email.com", authenticated: true)
    session[:user_id] = @walter.id
  end

  test "should get new for authenticated users" do
    create_authenticated_user
    get :new
    assert_template :new
    assert_response :success
  end

  test "should not get new for guests" do
    get :new
    assert_response :redirect
  end

  test "should get create for authenticated users" do
    create_authenticated_user
    params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg"}}
    post :create, params
    assert_response :redirect
    # assert_template :show
  end
  #
  # test "creating a product should increase the database" do
  #   assert_difference("Product.count", 1) do
  #     params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg", user_id: 1}}
  #     post :create, params
  #   end
  # end
  #
  # test "should get index" do
  #   get :index
  #   assert_template :index
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get :show, {id: products(:valid_penguin).id}
  #   assert_response :success
  # end
  #
  # test "should get update" do
  #   params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg", user_id: 1}}
  #   patch :update, id: products(:valid_penguin).id, params
  #   assert_response :redirect
  # end
  #
  # test "should get edit" do
  #   get :edit, {id: products(:valid_penguin).id}
  #   assert_response :success
  # end
  #
  # test "should be able to inactivate" do
  #   get :activation, {id: products(:valid_penguin).id}
  #   assert_response :redirect
  # end

end
