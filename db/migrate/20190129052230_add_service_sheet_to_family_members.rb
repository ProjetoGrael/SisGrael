class AddServiceSheetToFamilyMembers < ActiveRecord::Migration[5.1]
  def change
    add_reference :family_members, :service_sheet, foreign_key: true
  end
end
