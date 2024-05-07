class AddRenewedBoolToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :renewed_bool, :boolean, default: false
  end
end
