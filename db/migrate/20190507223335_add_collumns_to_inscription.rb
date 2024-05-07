class AddCollumnsToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :situation, :integer, default:  0
    add_column :inscriptions, :counsel_opnion, :string
  end
end
