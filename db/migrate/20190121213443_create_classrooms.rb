class CreateClassrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :classrooms do |t|
      t.boolean :active, default: true
      t.string :name
      t.string :fantasy_name
      t.references :course, foreign_key: true
      t.references :teacher, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
