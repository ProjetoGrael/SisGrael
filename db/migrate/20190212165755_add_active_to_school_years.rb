class AddActiveToSchoolYears < ActiveRecord::Migration[5.1]
  def change
    add_column :school_years, :active, :boolean, default: true
  end
end
