require 'test_helper'

class QuestionLabelsControllerTest < ActionController::TestCase
  setup do
    @question_label = question_labels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_labels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_label" do
    assert_difference('QuestionLabel.count') do
      post :create, question_label: { name: @question_label.name, status: @question_label.status }
    end

    assert_redirected_to question_label_path(assigns(:question_label))
  end

  test "should show question_label" do
    get :show, id: @question_label
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_label
    assert_response :success
  end

  test "should update question_label" do
    put :update, id: @question_label, question_label: { name: @question_label.name, status: @question_label.status }
    assert_redirected_to question_label_path(assigns(:question_label))
  end

  test "should destroy question_label" do
    assert_difference('QuestionLabel.count', -1) do
      delete :destroy, id: @question_label
    end

    assert_redirected_to question_labels_path
  end
end
