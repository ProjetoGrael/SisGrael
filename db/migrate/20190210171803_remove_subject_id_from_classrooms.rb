class RemoveSubjectIdFromClassrooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :classrooms, :subject_id
  end
end
