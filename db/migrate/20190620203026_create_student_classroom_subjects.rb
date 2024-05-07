class CreateStudentClassroomSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :student_classroom_subjects do |t|
      t.references :inscription, foreign_key: true
      t.references :classroom_subject, foreign_key: true
      t.boolean :show,  default: true

      t.timestamps
    end
  end
end
