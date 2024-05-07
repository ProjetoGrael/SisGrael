class AddHolidayToLesson < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :holiday, :boolean, default: false
  end
end
