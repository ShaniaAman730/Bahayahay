require "test_helper"

class RealtorSignupControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get realtor_signup_new_url
    assert_response :success
  end
end
