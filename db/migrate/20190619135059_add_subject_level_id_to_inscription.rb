class AddSubjectLevelIdToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :subject_level_id, :integer
  end
end
