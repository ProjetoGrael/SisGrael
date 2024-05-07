class AddActiveToSubjectLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :subject_levels, :active, :boolean, default: true
  end
end
