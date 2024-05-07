class CreateTransactionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :transaction_categories do |t|
      t.string :description

      t.timestamps
    end
  end
end
