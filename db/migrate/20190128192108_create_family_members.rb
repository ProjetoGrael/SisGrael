class CreateFamilyMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :family_members do |t|
      t.string :name
      t.integer :age
      t.integer :scholarity
      t.string :occupation
      t.decimal :income
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
