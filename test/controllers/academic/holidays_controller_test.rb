require 'test_helper'

class Academic::HolidaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @academic_holiday = academic_holidays(:one)
  end

  test "should get index" do
    get academic_holidays_url
    assert_response :success
  end

  test "should get new" do
    get new_academic_holiday_url
    assert_response :success
  end

  test "should create academic_holiday" do
    assert_difference('Academic::Holiday.count') do
      post academic_holidays_url, params: { academic_holiday: { day: @academic_holiday.day, name: @academic_holiday.name, school_year_id: @academic_holiday.school_year_id } }
    end

    assert_redirected_to academic_holiday_url(Academic::Holiday.last)
  end

  test "should show academic_holiday" do
    get academic_holiday_url(@academic_holiday)
    assert_response :success
  end

  test "should get edit" do
    get edit_academic_holiday_url(@academic_holiday)
    assert_response :success
  end

  test "should update academic_holiday" do
    patch academic_holiday_url(@academic_holiday), params: { academic_holiday: { day: @academic_holiday.day, name: @academic_holiday.name, school_year_id: @academic_holiday.school_year_id } }
    assert_redirected_to academic_holiday_url(@academic_holiday)
  end

  test "should destroy academic_holiday" do
    assert_difference('Academic::Holiday.count', -1) do
      delete academic_holiday_url(@academic_holiday)
    end

    assert_redirected_to academic_holidays_url
  end
end
