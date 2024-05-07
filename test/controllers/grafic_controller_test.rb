require 'test_helper'

class GraficControllerTest < ActionDispatch::IntegrationTest
  test "should get time_stay" do
    get grafic_time_stay_url
    assert_response :success
  end

end
