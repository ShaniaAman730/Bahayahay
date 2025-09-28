require "test_helper"

class RealtyMembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get realty_memberships_create_url
    assert_response :success
  end

  test "should get update" do
    get realty_memberships_update_url
    assert_response :success
  end

  test "should get destroy" do
    get realty_memberships_destroy_url
    assert_response :success
  end
end
