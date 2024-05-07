class AddTransactionCategoryToTransactions < ActiveRecord::Migration[5.1]
  def change
    change_table :transactions do |t|
      t.references :transaction_category
    end
  end
end
