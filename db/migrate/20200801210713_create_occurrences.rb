class CreateOccurrences < ActiveRecord::Migration[5.1]
  def change
    create_table :occurrences do |t|
      t.references :student, foreign_key: true
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
