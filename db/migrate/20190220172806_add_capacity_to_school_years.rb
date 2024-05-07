class AddCapacityToSchoolYears < ActiveRecord::Migration[5.1]
  def change
    add_column :school_years, :capacity, :integer, default: 0
  end
end
