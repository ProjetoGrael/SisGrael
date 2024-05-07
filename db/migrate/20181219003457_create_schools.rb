class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :number_students, default: 0

      t.timestamps
    end
  end
end
