require "test_helper"

class AccreditationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get accreditations_create_url
    assert_response :success
  end

  test "should get update" do
    get accreditations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get accreditations_destroy_url
    assert_response :success
  end
end
