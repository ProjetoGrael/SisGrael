require 'test_helper'

class SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get schools_new_url
    assert_response :success
  end

  test "should get create" do
    get schools_create_url
    assert_response :success
  end

  test "should get update" do
    get schools_update_url
    assert_response :success
  end

  test "should get edit" do
    get schools_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get schools_destroy_url
    assert_response :success
  end

  test "should get index" do
    get schools_index_url
    assert_response :success
  end

end
