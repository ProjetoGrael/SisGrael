class AddMainToClassroom < ActiveRecord::Migration[5.1]
  def change
    add_column :classrooms, :main_id, :integer
  end
end
