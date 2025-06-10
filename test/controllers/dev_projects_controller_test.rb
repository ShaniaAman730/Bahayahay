require "test_helper"

class DevProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dev_project = dev_projects(:one)
  end

  test "should get index" do
    get dev_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_dev_project_url
    assert_response :success
  end

  test "should create dev_project" do
    assert_difference("DevProject.count") do
      post dev_projects_url, params: { dev_project: { address: @dev_project.address, description: @dev_project.description, property_type: @dev_project.property_type, title: @dev_project.title } }
    end

    assert_redirected_to dev_project_url(DevProject.last)
  end

  test "should show dev_project" do
    get dev_project_url(@dev_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_dev_project_url(@dev_project)
    assert_response :success
  end

  test "should update dev_project" do
    patch dev_project_url(@dev_project), params: { dev_project: { address: @dev_project.address, description: @dev_project.description, property_type: @dev_project.property_type, title: @dev_project.title } }
    assert_redirected_to dev_project_url(@dev_project)
  end

  test "should destroy dev_project" do
    assert_difference("DevProject.count", -1) do
      delete dev_project_url(@dev_project)
    end

    assert_redirected_to dev_projects_url
  end
end
