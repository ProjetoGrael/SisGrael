require 'test_helper'

class FreeTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @free_time = free_times(:one)
  end

  test "should get index" do
    get free_times_url
    assert_response :success
  end

  test "should get new" do
    get new_free_time_url
    assert_response :success
  end

  test "should create free_time" do
    assert_difference('FreeTime.count') do
      post free_times_url, params: { free_time: { day: @free_time.day, finish_at: @free_time.finish_at, start_at: @free_time.start_at, user_id: @free_time.user_id } }
    end

    assert_redirected_to free_time_url(FreeTime.last)
  end

  test "should show free_time" do
    get free_time_url(@free_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_free_time_url(@free_time)
    assert_response :success
  end

  test "should update free_time" do
    patch free_time_url(@free_time), params: { free_time: { day: @free_time.day, finish_at: @free_time.finish_at, start_at: @free_time.start_at, user_id: @free_time.user_id } }
    assert_redirected_to free_time_url(@free_time)
  end

  test "should destroy free_time" do
    assert_difference('FreeTime.count', -1) do
      delete free_time_url(@free_time)
    end

    assert_redirected_to free_times_url
  end
end
