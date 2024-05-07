class FixHolidayAttributeInLessons < ActiveRecord::Migration[5.1]
  def change
    Academic::Lesson.where(classroom_subject: Academic::ClassroomSubject.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current))).each do |lesson|
      bool = false
      Academic::Holiday.where(school_year: Academic::SchoolYear.current).each do |holiday|
        if(lesson.day == holiday.day)
          bool = true
        end
      end
      lesson.holiday = bool
      lesson.save
    end
  end
end
