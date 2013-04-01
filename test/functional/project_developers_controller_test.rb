require 'test_helper'

class ProjectDevelopersControllerTest < ActionController::TestCase
  setup do
    @project_developer = project_developers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_developers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_developer" do
    assert_difference('ProjectDeveloper.count') do
      post :create, project_developer: {  }
    end

    assert_redirected_to project_developer_path(assigns(:project_developer))
  end

  test "should show project_developer" do
    get :show, id: @project_developer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_developer
    assert_response :success
  end

  test "should update project_developer" do
    put :update, id: @project_developer, project_developer: {  }
    assert_redirected_to project_developer_path(assigns(:project_developer))
  end

  test "should destroy project_developer" do
    assert_difference('ProjectDeveloper.count', -1) do
      delete :destroy, id: @project_developer
    end

    assert_redirected_to project_developers_path
  end
end
