class RemoveStudentIdFromSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    remove_column :subject_histories, :student_id, :integer
  end
end
