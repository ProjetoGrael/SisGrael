class AddTotalIncomeToServiceSheet < ActiveRecord::Migration[5.1]
  def change
    add_column :service_sheets, :total_income, :decimal
  end
end
