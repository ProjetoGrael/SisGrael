require 'test_helper'

class LaborMarketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @labor_market = labor_markets(:one)
  end

  test "should get index" do
    get labor_markets_url
    assert_response :success
  end

  test "should get new" do
    get new_labor_market_url
    assert_response :success
  end

  test "should create labor_market" do
    assert_difference('LaborMarket.count') do
      post labor_markets_url, params: { labor_market: { company: @labor_market.company, company_address: @labor_market.company_address, company_phone_number: @labor_market.company_phone_number, contact_email: @labor_market.contact_email, contact_name: @labor_market.contact_name, contact_office: @labor_market.contact_office, date_closure: @labor_market.date_closure, date_exit: @labor_market.date_exit, date_start: @labor_market.date_start, student_id: @labor_market.student_id, student_occupation_area: @labor_market.student_occupation_area, student_office: @labor_market.student_office, year: @labor_market.year } }
    end

    assert_redirected_to labor_market_url(LaborMarket.last)
  end

  test "should show labor_market" do
    get labor_market_url(@labor_market)
    assert_response :success
  end

  test "should get edit" do
    get edit_labor_market_url(@labor_market)
    assert_response :success
  end

  test "should update labor_market" do
    patch labor_market_url(@labor_market), params: { labor_market: { company: @labor_market.company, company_address: @labor_market.company_address, company_phone_number: @labor_market.company_phone_number, contact_email: @labor_market.contact_email, contact_name: @labor_market.contact_name, contact_office: @labor_market.contact_office, date_closure: @labor_market.date_closure, date_exit: @labor_market.date_exit, date_start: @labor_market.date_start, student_id: @labor_market.student_id, student_occupation_area: @labor_market.student_occupation_area, student_office: @labor_market.student_office, year: @labor_market.year } }
    assert_redirected_to labor_market_url(@labor_market)
  end

  test "should destroy labor_market" do
    assert_difference('LaborMarket.count', -1) do
      delete labor_market_url(@labor_market)
    end

    assert_redirected_to labor_markets_url
  end
end
