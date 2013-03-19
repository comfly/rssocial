require 'test_helper'

class FeederControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

end
