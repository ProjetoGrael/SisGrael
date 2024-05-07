require 'test_helper'

class Academic::ClassroomSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classroom_subject = classroom_subjects(:one)
  end

  test "should get index" do
    get classroom_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_classroom_subject_url
    assert_response :success
  end

  test "should create classroom_subject" do
    assert_difference('ClassroomSubject.count') do
      post classroom_subjects_url, params: { classroom_subject: {  } }
    end

    assert_redirected_to classroom_subject_url(ClassroomSubject.last)
  end

  test "should show classroom_subject" do
    get classroom_subject_url(@classroom_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_classroom_subject_url(@classroom_subject)
    assert_response :success
  end

  test "should update classroom_subject" do
    patch classroom_subject_url(@classroom_subject), params: { classroom_subject: {  } }
    assert_redirected_to classroom_subject_url(@classroom_subject)
  end

  test "should destroy classroom_subject" do
    assert_difference('ClassroomSubject.count', -1) do
      delete classroom_subject_url(@classroom_subject)
    end

    assert_redirected_to classroom_subjects_url
  end
end
