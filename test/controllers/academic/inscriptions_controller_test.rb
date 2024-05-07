require 'test_helper'

class Academic::InscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @academic_inscription = academic_inscriptions(:one)
  end

  test "should get index" do
    get academic_inscriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_academic_inscription_url
    assert_response :success
  end

  test "should create academic_inscription" do
    assert_difference('Academic::Inscription.count') do
      post academic_inscriptions_url, params: { academic_inscription: {  } }
    end

    assert_redirected_to academic_inscription_url(Academic::Inscription.last)
  end

  test "should show academic_inscription" do
    get academic_inscription_url(@academic_inscription)
    assert_response :success
  end

  test "should get edit" do
    get edit_academic_inscription_url(@academic_inscription)
    assert_response :success
  end

  test "should update academic_inscription" do
    patch academic_inscription_url(@academic_inscription), params: { academic_inscription: {  } }
    assert_redirected_to academic_inscription_url(@academic_inscription)
  end

  test "should destroy academic_inscription" do
    assert_difference('Academic::Inscription.count', -1) do
      delete academic_inscription_url(@academic_inscription)
    end

    assert_redirected_to academic_inscriptions_url
  end
end
