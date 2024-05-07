class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.references :student, foreign_key: true
      t.references :user, foreign_key: true
      t.string :reason
      t.date :date_of_interview
      t.time :time_of_interview
    end
  end
end
