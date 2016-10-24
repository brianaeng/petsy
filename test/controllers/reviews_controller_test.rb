require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  #Need some way to login so tests can run

  test "should get new" do
    get :new, product_id: 1
    assert_template :new
    assert_response :success
  end

  #Need to figure out how to tie these to Product controller (since they're nested)
  test "should get create" do
    params = {review: {rating: 5, title: "test", description: "test review", product_id: 1}}
    post :create, params
    assert_response :redirect
  end

  test "creating should add one to the database" do
    assert_difference('Review.count', 1) do
      params = {review: {rating: 5, title: "test", description: "test review", product_id: 1}}
      post :create, params
    end
  end

  #Don't need the below since we're calling reviews via Product show (product.reviews)
  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

  #Don't need the below since we're not allowing editing or deletion of reviews
  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end
