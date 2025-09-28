require "test_helper"

class RealtiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get realties_index_url
    assert_response :success
  end

  test "should get show" do
    get realties_show_url
    assert_response :success
  end

  test "should get new" do
    get realties_new_url
    assert_response :success
  end

  test "should get create" do
    get realties_create_url
    assert_response :success
  end

  test "should get edit" do
    get realties_edit_url
    assert_response :success
  end

  test "should get update" do
    get realties_update_url
    assert_response :success
  end
end
