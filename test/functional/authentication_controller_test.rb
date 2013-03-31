require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  test "should get loginUser" do
    get :loginUser
    assert_response :success
  end

end
