require 'test_helper'

class CachedResultsControllerTest < ActionController::TestCase
  setup do
    @cached_result = cached_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cached_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cached_result" do
    assert_difference('CachedResult.count') do
      post :create, cached_result: { name: @cached_result.name, result: @cached_result.result }
    end

    assert_redirected_to cached_result_path(assigns(:cached_result))
  end

  test "should show cached_result" do
    get :show, id: @cached_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cached_result
    assert_response :success
  end

  test "should update cached_result" do
    put :update, id: @cached_result, cached_result: { name: @cached_result.name, result: @cached_result.result }
    assert_redirected_to cached_result_path(assigns(:cached_result))
  end

  test "should destroy cached_result" do
    assert_difference('CachedResult.count', -1) do
      delete :destroy, id: @cached_result
    end

    assert_redirected_to cached_results_path
  end
end
