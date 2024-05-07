class AddReferencesToAddressEntities < ActiveRecord::Migration[5.1]
  def change
    change_table :cities do |t|
      t.references :state
    end

    change_table :neighborhoods do |t|
      t.references :city
    end
  end
end
