class RemoveExtraStuffFromTeachers < ActiveRecord::Migration[5.1]
  def change
    remove_column :teachers, :name
    remove_column :teachers, :email
    remove_column :teachers, :photo
  end
end
