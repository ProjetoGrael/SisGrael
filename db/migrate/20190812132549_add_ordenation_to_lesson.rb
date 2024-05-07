class AddOrdenationToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :ordenation, :integer
  end
end
