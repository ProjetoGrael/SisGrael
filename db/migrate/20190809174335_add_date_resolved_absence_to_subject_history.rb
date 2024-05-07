class AddDateResolvedAbsenceToSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :subject_histories, :date_resolved_absence, :datetime
  end
end
