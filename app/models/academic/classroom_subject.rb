class Academic::ClassroomSubject < ApplicationRecord
  belongs_to :classroom
  belongs_to :subject
  belongs_to :teacher, optional: true
  has_many :subject_histories, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :student_classroom_subjects, dependent: :destroy

  validate :school_year_must_be_active
  validate :cant_add_leveled_classroom_subject_to_classroom_yet, on: :create
  validates :start_time, presence: true
  validates :finish_time, presence: true

  after_create :generate_lessons
  after_create :create_student_classroom_subject
  after_save :new_subject_history_for_classroom_students
  after_save :ord_lesson

  after_update :update_lessons
  
  def get_subject_history(inscripion)
    subject_histories.find_by(inscription_id: inscripion.id)
  end

  def ord_lesson
    i = 0
    lessons.order('day').each do |lesson|
      lesson.update_attributes(ordenation: i)
      i+=1
    end
  end

  private

    def generate_lessons
      school_year = classroom.school_year
      holidays = Academic::Holiday.where(school_year: school_year)
      days = {
        0 => false,  # Domingo
        1 => lesson_on_monday,
        2 => lesson_on_tuesday,
        3 => lesson_on_wednesday,
        4 => lesson_on_thursday,
        5 => lesson_on_friday,
        6 => false  # Sábado
      }
      start_day = school_year.start
      final_day = school_year.final
      reference_day = start_day

      while reference_day <= final_day
        if days[reference_day.wday]
          Academic::Lesson.create(
            classroom_subject_id: id, 
            day: reference_day,
            holiday: holidays.find_by(day: reference_day).present?
          )
        end
        reference_day += 1.day
      end
    end

    def update_lessons
      school_year = classroom.school_year
      holidays = Academic::Holiday.where(school_year: school_year)
      now = Time.now.utc.to_date
      lessons.each {|lesson| lesson.destroy() if lesson.day > now}
      days = {
        0 => false,  # Domingo
        1 => lesson_on_monday,
        2 => lesson_on_tuesday,
        3 => lesson_on_wednesday,
        4 => lesson_on_thursday,
        5 => lesson_on_friday,
        6 => false  # Sábado
      }
      start_day = now
      final_day = school_year.final
      reference_day = start_day
      
      while reference_day <= final_day
        if days[reference_day.wday]
          Academic::Lesson.create(
            classroom_subject_id: id, 
            day: reference_day,
            holiday: holidays.find_by(day: reference_day).present?
          )
        end
        reference_day += 1.day
      end
    end

    def new_subject_history_for_classroom_students
      classroom.students.each do |student|
        inscription = student.inscriptions.find_by!(classroom_id: classroom.id)
        next unless inscription.active
        Academic::SubjectHistory.create(
          inscription_id: inscription.id,
          classroom_subject_id: id
        )
      end
    end
    
    def self.sum_of_student
      sum = 0
      all.each do |sub_class|
        sum += sub_class.subject_histories.where(show: true).length
      end
      sum
    end

    def school_year_must_be_active
      if classroom.school_year.inactive?
        errors.add(:base, 'Período Letivo precisa estar ativo para alterações.')
      end
    end  
    
    def cant_add_leveled_classroom_subject_to_classroom_yet
      if subject.leveled and classroom.students.any?
        errors.add(:base, 'No momento, não é possível adicionar curso nivelado com alunos já inseridos na turma.')
      end
    end

    def create_student_classroom_subject
      classroom.inscriptions.active.each do |inscripion|
        Academic::StudentClassroomSubject.create(inscription_id: inscripion.id, classroom_subject_id: id)
      end
    end
end
