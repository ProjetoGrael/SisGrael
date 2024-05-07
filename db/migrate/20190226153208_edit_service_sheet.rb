class EditServiceSheet < ActiveRecord::Migration[5.1]
  def change
    add_column :service_sheets, :current_working, :boolean
    remove_column :service_sheets, :other
    remove_column :service_sheets, :other_text
    add_column :service_sheets, :other_expenses, :boolean
    add_column :service_sheets, :other_expenses_text, :text
    remove_column :service_sheets, :family_income
  end
end