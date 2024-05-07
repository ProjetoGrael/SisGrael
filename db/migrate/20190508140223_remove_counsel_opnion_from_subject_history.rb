class RemoveCounselOpnionFromSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    remove_column :subject_histories, :counsel_opinion, :string
  end
end
