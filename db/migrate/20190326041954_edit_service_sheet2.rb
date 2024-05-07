class EditServiceSheet2 < ActiveRecord::Migration[5.1]
  def change
      change_table :service_sheets do |t|
          t.remove :light
          t.remove :light_value
          t.remove :water 
          t.remove :water_value 
          t.remove :phone 
          t.remove :phone_value 
          t.remove :internet 
          t.remove :internet_value 
          t.remove :medication_expense
          t.remove :medication_value 
          t.remove :iptu 
          t.remove :iptu_value 
          t.remove :food 
          t.remove :food_value 
          t.remove :other_expenses 
          t.remove :other_expenses_text
          t.text :disabled_person_text
          t.text :has_documentation_text
      end
  end
end
