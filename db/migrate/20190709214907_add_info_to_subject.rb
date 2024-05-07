class AddInfoToSubject < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :professionalized, :boolean
    add_column :subjects, :sport, :boolean
  end
end
