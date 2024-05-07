class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.boolean :active, default: true
      t.string :name
      t.text :planning

      t.timestamps
    end
  end
end
