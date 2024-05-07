class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.text :notes
      t.text :observations
      t.date :day
      t.references :classroom_subject, foreign_key: true

      t.timestamps
    end
  end
end
