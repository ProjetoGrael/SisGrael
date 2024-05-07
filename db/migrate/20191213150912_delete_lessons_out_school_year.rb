class DeleteLessonsOutSchoolYear < ActiveRecord::Migration[5.1]
  def change
    Academic::Lesson.where(ordenation: nil).where(day: "2019-07-12").each do |lesson|
      lesson.presences.each do |presence|
        presence.delete
      end
      lesson.delete
    end
  end
end
