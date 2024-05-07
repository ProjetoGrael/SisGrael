class AddSchoolLevelToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :completed, :integer, default: 1
    add_column :students, :specific_school_level, :integer
  end
end
