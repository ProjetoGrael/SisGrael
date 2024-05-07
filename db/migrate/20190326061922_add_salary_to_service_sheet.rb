class AddSalaryToServiceSheet < ActiveRecord::Migration[5.1]
  def change
    add_column :service_sheets, :salary, :decimal
  end
end
