class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.decimal :value, precision: 20, scale: 2, default: 0
      t.decimal :accumulated_value, precision: 20, scale: 2, default: 0
      t.text :description, optional: true
      
      t.references :account, foreign_key: true
      t.references :responsible, polymorphic: true, index: true
      t.timestamps
    end
  end
end
