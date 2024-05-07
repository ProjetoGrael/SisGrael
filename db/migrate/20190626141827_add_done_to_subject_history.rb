class AddDoneToSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :subject_histories, :done, :boolean
  end
end
