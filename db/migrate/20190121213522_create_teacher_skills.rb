class CreateTeacherSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :teacher_skills do |t|
      t.references :teacher, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
