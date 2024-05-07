class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.decimal :total_value, precision: 20, scale: 2, default: 0
      t.decimal :current_value, precision: 20, scale: 2, default: 0

      t.timestamps
    end
  end
end
