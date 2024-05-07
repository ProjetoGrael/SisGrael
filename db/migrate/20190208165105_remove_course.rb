class RemoveCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :classrooms, :name
    remove_column :classrooms, :course_id
    drop_table :courses
  end
end
