require 'test_helper'

class Financial::TransactionCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction_category = transaction_categories(:one)
  end

  test "should get index" do
    get transaction_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_category_url
    assert_response :success
  end

  test "should create transaction_category" do
    assert_difference('TransactionCategory.count') do
      post transaction_categories_url, params: { transaction_category: { description: @transaction_category.description } }
    end

    assert_redirected_to transaction_category_url(TransactionCategory.last)
  end

  test "should show transaction_category" do
    get transaction_category_url(@transaction_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_category_url(@transaction_category)
    assert_response :success
  end

  test "should update transaction_category" do
    patch transaction_category_url(@transaction_category), params: { transaction_category: { description: @transaction_category.description } }
    assert_redirected_to transaction_category_url(@transaction_category)
  end

  test "should destroy transaction_category" do
    assert_difference('TransactionCategory.count', -1) do
      delete transaction_category_url(@transaction_category)
    end

    assert_redirected_to transaction_categories_url
  end
end
