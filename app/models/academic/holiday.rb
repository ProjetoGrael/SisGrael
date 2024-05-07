class Academic::Holiday < ApplicationRecord
  belongs_to :school_year

  after_save :add_holiday_attribute_in_lessons
  after_destroy :remove_holiday_attribute_in_lessons
  validates :day, uniqueness: true
  private

  def add_holiday_attribute_in_lessons
    Academic::Lesson.where(classroom_subject: Academic::ClassroomSubject.where(classroom: Academic::Classroom.where(school_year: self.school_year))).each do |lesson|
      if lesson.day == self.day
        lesson.holiday = true
        lesson.save
      end
    end
  end

  def remove_holiday_attribute_in_lessons
    Academic::Lesson.where(classroom_subject: Academic::ClassroomSubject.where(classroom: Academic::Classroom.where(school_year: self.school_year))).each do |lesson|
      if lesson.day == self.day
        lesson.holiday = false
        lesson.save
      end
    end
  end

end
