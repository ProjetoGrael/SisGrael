class AddFieldsToSubjectHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :subject_histories, :presence, :decimal
    add_column :subject_histories, :justified_absences, :integer
    add_column :subject_histories, :partial_counsel, :decimal
    add_column :subject_histories, :final_counsel, :decimal
    add_column :subject_histories, :counsel_opinion, :string
    add_column :subject_histories, :situation, :integer
  end
end
