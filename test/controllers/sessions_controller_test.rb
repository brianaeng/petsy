require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, {provider: "github"}
  end

  test "can create a user" do
    assert_difference('User.count', 1) do
      login_a_user
      assert_response :redirect
      assert_equal session[:user_id], User.find_by(uid: OmniAuth.config.mock_auth[:github][:uid], provider: 'github').id
    end
  end

  test "can delete a session" do
    delete :destroy
    assert_response :redirect
  end

end
