class AddDoneToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :done, :boolean, default: false
  end
end
