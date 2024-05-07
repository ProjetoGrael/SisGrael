class RenameOpnionOfInscription < ActiveRecord::Migration[5.1]
  def change
    rename_column :inscriptions, :counsel_opnion, :counsel_opinion
  end
end
