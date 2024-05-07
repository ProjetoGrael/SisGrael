class ModifySubjectHistories < ActiveRecord::Migration[5.1]
  def change
    remove_column :subject_histories, :classroom_id
    remove_column :subject_histories, :subject_id
    add_reference :subject_histories, :classroom_subject

  end
end
