class AddSubjectIdToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :subject_id, :integer
  end
end
