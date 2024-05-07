require 'test_helper'

class StatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get states_new_url
    assert_response :success
  end

  test "should get create" do
    get states_create_url
    assert_response :success
  end

  test "should get update" do
    get states_update_url
    assert_response :success
  end

  test "should get edit" do
    get states_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get states_destroy_url
    assert_response :success
  end

  test "should get index" do
    get states_index_url
    assert_response :success
  end

end
