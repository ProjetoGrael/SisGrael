class AddStudentNameToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :student_name, :string
  end
end
