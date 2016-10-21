require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "User with minimal information is valid" do
    users(:minimal_valid_user).valid?
    assert users(:minimal_valid_user).valid?
  end

  test "The user must have a valid email" do
    users(:no_email_user).invalid?
    assert users(:no_email_user).invalid?
    users(:invalid_email_user).invalid?
    assert users(:invalid_email_user).invalid?
  end

  test "The user must have a provider" do
    users(:no_provider_user).invalid?
    assert users(:no_provider_user).invalid?
  end

  test "The user must have an authentication status" do
    users(:no_authentication_status).invalid?
    assert users(:no_authentication_status).invalid?
  end
end
