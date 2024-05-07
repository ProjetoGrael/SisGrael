require 'test_helper'

class Financial::TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { account_id: @transaction.account_id, captation_id: @transaction.captation_id, institution_id: @transaction.institution_id, enterprise_id: @transaction.enterprise_id, :cost_id: @transaction.cost_id, :cost_type: @transaction.cost_type, value: @transaction.value } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { account_id: @transaction.account_id, captation_id: @transaction.captation_id, institution_id: @transaction.institution_id, enterprise_id: @transaction.enterprise_id, cost_id: @transaction.cost_id, cost_type: @transaction.cost_type, value: @transaction.value } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
