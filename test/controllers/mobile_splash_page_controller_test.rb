require 'test_helper'

class MobileSplashPageControllerTest < ActionController::TestCase
  test "should get view" do
    get :view
    assert_response :success
  end

end
