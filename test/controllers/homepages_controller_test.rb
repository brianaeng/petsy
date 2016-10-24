require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
  end

  #Not using for now
  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

end
