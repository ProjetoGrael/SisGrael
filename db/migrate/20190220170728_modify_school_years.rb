class ModifySchoolYears < ActiveRecord::Migration[5.1]
  def change
    remove_column :school_years, :active
    
    change_table :school_years do |t|
      t.integer :status, default: 0
    end

  end
end
