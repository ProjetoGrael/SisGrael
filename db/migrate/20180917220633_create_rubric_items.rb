class CreateRubricItems < ActiveRecord::Migration[5.1]
  def change
    create_table :rubric_items do |t|
      t.integer :numeration
      t.string :description
      t.decimal :value, precision: 20, scale: 2
      t.references :rubric, foreign_key: true

      t.timestamps
    end
  end
end
