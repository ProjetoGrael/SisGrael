class AddModificationDayStatusToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :modification_day_status, :date
  end
end
