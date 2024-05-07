class EditVocationalInterview < ActiveRecord::Migration[5.1]
  def change
    change_column :vocational_interviews, :live_with, :text
    change_column :vocational_interviews, :housing_condition, :text
  end
end



