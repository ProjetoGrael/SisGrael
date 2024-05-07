class AddScheduleToClassroomSubjects < ActiveRecord::Migration[5.1]
  def change
    change_table :classroom_subjects do |t|
      t.time :start_time
      t.time :finish_time
      t.boolean :lesson_on_monday, default: false
      t.boolean :lesson_on_tuesday, default: false
      t.boolean :lesson_on_wednesday, default: false
      t.boolean :lesson_on_thursday, default: false
      t.boolean :lesson_on_friday, default: false
    end
  end
end
