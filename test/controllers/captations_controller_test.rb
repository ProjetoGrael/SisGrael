require 'test_helper'

class Financial::CaptationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @captation = captations(:one)
  end

  test "should get index" do
    get captations_url
    assert_response :success
  end

  test "should get new" do
    get new_captation_url
    assert_response :success
  end

  test "should create captation" do
    assert_difference('Captation.count') do
      post captations_url, params: { captation: { project_id: @captation.project_id, source: @captation.source, value: @captation.value } }
    end

    assert_redirected_to captation_url(Captation.last)
  end

  test "should show captation" do
    get captation_url(@captation)
    assert_response :success
  end

  test "should get edit" do
    get edit_captation_url(@captation)
    assert_response :success
  end

  test "should update captation" do
    patch captation_url(@captation), params: { captation: { project_id: @captation.project_id, source: @captation.source, value: @captation.value } }
    assert_redirected_to captation_url(@captation)
  end

  test "should destroy captation" do
    assert_difference('Captation.count', -1) do
      delete captation_url(@captation)
    end

    assert_redirected_to captations_url
  end
end
