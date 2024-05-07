class CreateProgramAids < ActiveRecord::Migration[5.1]
  def change
    create_table :program_aids do |t|
      t.references :student, foreign_key: true
      t.references :assistance_program, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
