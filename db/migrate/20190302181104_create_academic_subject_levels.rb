class CreateAcademicSubjectLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :academic_subject_levels do |t|
      t.string :name
      t.integer :order
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
