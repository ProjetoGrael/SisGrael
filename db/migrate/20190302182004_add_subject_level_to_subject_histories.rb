class AddSubjectLevelToSubjectHistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :subject_histories, :subject_level, foreign_key: true
  end
end
