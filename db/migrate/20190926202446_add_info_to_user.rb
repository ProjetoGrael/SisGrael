class AddInfoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :medical_report, :string
    add_column :students, :behavior, :string
    add_column :students, :difficulties, :string
    
  end
end
