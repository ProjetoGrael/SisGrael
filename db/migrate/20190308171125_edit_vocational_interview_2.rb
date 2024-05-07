class EditVocationalInterview2 < ActiveRecord::Migration[5.1]
  def change
    add_column :vocational_interviews, :other_motivation, :text
  end
end
