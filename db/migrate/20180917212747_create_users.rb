class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :picture, optional: true
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
