require 'test_helper'

class SubjectHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subject_history = subject_histories(:one)
  end

  test "should get index" do
    get subject_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_subject_history_url
    assert_response :success
  end

  test "should create subject_history" do
    assert_difference('SubjectHistory.count') do
      post subject_histories_url, params: { subject_history: {  } }
    end

    assert_redirected_to subject_history_url(SubjectHistory.last)
  end

  test "should show subject_history" do
    get subject_history_url(@subject_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_subject_history_url(@subject_history)
    assert_response :success
  end

  test "should update subject_history" do
    patch subject_history_url(@subject_history), params: { subject_history: {  } }
    assert_redirected_to subject_history_url(@subject_history)
  end

  test "should destroy subject_history" do
    assert_difference('SubjectHistory.count', -1) do
      delete subject_history_url(@subject_history)
    end

    assert_redirected_to subject_histories_url
  end
end
