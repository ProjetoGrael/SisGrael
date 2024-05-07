class AddColumnsVocationalInterView < ActiveRecord::Migration[5.1]
  def change
    add_column :vocational_interviews, :recreation_doing, :text
    add_column :vocational_interviews, :ethnicity, :integer 
    add_column :vocational_interviews, :amount_repetitions, :integer
  end
end
