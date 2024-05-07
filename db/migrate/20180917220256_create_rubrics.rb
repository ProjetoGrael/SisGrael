class CreateRubrics < ActiveRecord::Migration[5.1]
  def change
    create_table :rubrics do |t|
      t.integer :numeration
      t.string :description
      t.decimal :value, precision: 20, scale: 2
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
