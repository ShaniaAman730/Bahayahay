require "test_helper"

class DevProjectControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dev_project_new_url
    assert_response :success
  end

  test "should get edit" do
    get dev_project_edit_url
    assert_response :success
  end

  test "should get index" do
    get dev_project_index_url
    assert_response :success
  end

  test "should get show" do
    get dev_project_show_url
    assert_response :success
  end
end
