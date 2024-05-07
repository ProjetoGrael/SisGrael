require 'test_helper'

class CertificationControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get certification_show_url
    assert_response :success
  end

end
