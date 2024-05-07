class RemoveFixedCostsAndCurrentValueFromTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :accumulated_value, :decimal
  end
end
