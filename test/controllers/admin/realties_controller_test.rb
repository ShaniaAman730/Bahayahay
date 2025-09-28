require "test_helper"

class Admin::RealtiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_realties_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_realties_show_url
    assert_response :success
  end

  test "should get approve" do
    get admin_realties_approve_url
    assert_response :success
  end

  test "should get reject" do
    get admin_realties_reject_url
    assert_response :success
  end
end
