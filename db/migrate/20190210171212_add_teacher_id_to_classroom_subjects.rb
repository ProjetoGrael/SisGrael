class AddTeacherIdToClassroomSubjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :classroom_subjects, :teacher, foreign_key: true
  end
end
