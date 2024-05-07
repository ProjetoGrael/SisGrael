class CreateCaptations < ActiveRecord::Migration[5.1]
  def change
    create_table :captations do |t|
      t.string :source
      t.decimal :value, precision: 20, scale: 2
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
