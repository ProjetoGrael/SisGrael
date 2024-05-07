class RemoveTeacherIdFromClassrooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :classrooms, :teacher_id
  end
end
