class CreateInscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :inscriptions do |t|
      t.references :student, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
