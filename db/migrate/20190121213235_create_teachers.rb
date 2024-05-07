class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.boolean :active, default: true
      t.string :name
      t.date :birth

      t.timestamps
    end
  end
end
