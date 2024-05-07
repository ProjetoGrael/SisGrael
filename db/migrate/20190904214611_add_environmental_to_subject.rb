class AddEnvironmentalToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :environmental, :boolean, default: false
  end
end
