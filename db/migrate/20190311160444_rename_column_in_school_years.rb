class RenameColumnInSchoolYears < ActiveRecord::Migration[5.1]
  def change
    rename_column :school_years, :end, :final
  end
end