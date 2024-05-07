class AddRenewableDateToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :renewable_date, :date
  end
end
