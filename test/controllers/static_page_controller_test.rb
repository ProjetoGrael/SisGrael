require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest
  test "should get principal" do
    get static_page_principal_url
    assert_response :success
  end

  test "should get financeiro" do
    get static_page_financeiro_url
    assert_response :success
  end

  test "should get academico" do
    get static_page_academico_url
    assert_response :success
  end

  test "should get secretaria" do
    get static_page_secretaria_url
    assert_response :success
  end

end
