require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_template :new
    assert_response :success
  end

  test "should get create" do
    params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg", user_id: 1}}
    post :create, params
    assert_response :success
  end

  test "creating a product should increase the database" do
    assert_difference("Product.count", 1) do
      params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg", user_id: 1}}
      post :create, params
    end
  end

  test "should get index" do
    get :index
    assert_template :index
    assert_response :success
  end

  test "should get show" do
    get :show, {id: products(:valid_penguin).id}
    assert_response :success
  end

  test "should get update" do
    params = {product: {name: "cat", price: 10000, quantity: 12, description: "purrfect", picture: "cat.jpg", user_id: 1}}
    patch :update, id: products(:valid_penguin).id, params
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, {id: products(:valid_penguin).id}
    assert_response :success
  end

  test "should be able to inactivate" do
    get :activation, {id: products(:valid_penguin).id}
    assert_response :redirect
  end

end
