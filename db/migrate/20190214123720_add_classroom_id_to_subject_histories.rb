class AddClassroomIdToSubjectHistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :subject_histories, :classroom, foreign_key: true
  end
end
