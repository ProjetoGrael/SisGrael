class AddOpinionToClassroom < ActiveRecord::Migration[5.1]
  def change
    add_column :classrooms, :opinion, :string
  end
end
