class AddLeveledToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :leveled, :boolean, default: false
  end
end
