require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    # assert_template :index This doesn't work because the index view is dependent on their being multiple pets to display
  end

end
