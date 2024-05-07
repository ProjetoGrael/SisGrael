class AddPerCaptaIncomeToServiceSheet < ActiveRecord::Migration[5.1]
  def change
    add_column :service_sheets, :per_capta_income, :decimal
  end
end
