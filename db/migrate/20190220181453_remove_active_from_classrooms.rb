class RemoveActiveFromClassrooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :classrooms, :active
  end
end
