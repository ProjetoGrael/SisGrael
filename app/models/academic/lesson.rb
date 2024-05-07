class Academic::Lesson < ApplicationRecord
  belongs_to :classroom_subject
  has_many :presences, dependent: :destroy

  validate :must_be_inside_school_year, :cant_have_two_class_in_same_day
  after_create :generate_presences

  after_create :reorder_lesson

  after_save :add_holiday_attribute
  
  private

  def add_holiday_attribute
    #Só executa o código, se o dia da aula mudou...
    #Para melhorar a performance
    if self.saved_change_to_day?
      Academic::Holiday.where(school_year: self.classroom_subject.classroom.school_year).each do |holiday|
        if self.day == holiday.day
          self.holiday = true
        end
      end
    end 
  end

  def reorder_lesson
    if classroom_subject.created_at < Time.now - 1.minutes
      classroom_subject.ord_lesson
    end
  end

  def generate_presences
    classroom_subject.classroom.students.each do |student|
      Academic::Presence.create(student_id: student.id, lesson_id: id)
    end
  end
  def cant_have_two_class_in_same_day
    lesson = Academic::Lesson.where(classroom_subject: self.classroom_subject).find_by(day: day)
    errors.add(:day, "já existente.") if lesson.present? && !lesson.id.equal?(id) 
  end

  #Não está sendo mais usado, pois estava gerando inconsistência, já que haviam feriados sendo criados depois que as aulas eram criadas,
  #Foi definido por usar uma flag que diz se a aula ocorre em um dia de feriado ou não
  def cant_be_on_a_holiday
    holidays = classroom_subject.classroom.school_year.holidays

    if holidays.where(day: day).any?
      errors.add(:day, 'não pode coincidir com um Dia Sem Aula.')
    end
  end

  def must_be_inside_school_year
    school_year = classroom_subject.classroom.school_year
    unless school_year.start <= day && school_year.final >= day
      errors.add(:day, 'não pode ser fora do Período Letivo')
    end
  end
end
