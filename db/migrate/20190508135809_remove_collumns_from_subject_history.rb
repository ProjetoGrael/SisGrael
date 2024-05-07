class RemoveCollumnsFromSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    remove_column :subject_histories, :situation, :integer
    
  end
end
