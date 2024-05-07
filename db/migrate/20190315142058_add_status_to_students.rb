class AddStatusToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :status, :integer, default: 0
  end
end
