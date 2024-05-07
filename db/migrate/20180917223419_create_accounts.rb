class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :number
      t.string :agency
      t.string :bank
      t.decimal :current_value, precision: 20, scale: 2

      t.timestamps
    end
  end
end
