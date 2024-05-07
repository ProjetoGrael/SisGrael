require 'csv'
class Academic::SchoolYear < ApplicationRecord
  has_many :classrooms
  has_many :inscriptions, through: :classrooms
  has_many :holidays, class_name: 'Academic::Holiday'
  has_many :occurrences

  validates :name, uniqueness: true, presence: true
  validates :start, presence: true
  validates :final, presence: true
  validate :cant_be_inside_another_school_year
  validate :year_should_be_valid
  enum status: {
    inactive: 0,
    active: 1,
    preparation: 2
  }

  after_update :update_lessons

  mount_uploader :background_image, BackGroundImageUploader
  def self.current
    school_year = Academic::SchoolYear.find_by_status(:active)
    school_year ||= Academic::SchoolYear.where(status: :preparation).order(:start).first
    school_year ||= Academic::SchoolYear.last
    return school_year
  end

  def self.active
    return self.where(status: :active).any? ? self.where(status: :active) : [self.last]
  end

  def csv_info_school_year
    CSV.generate(headers: true) do |csv|
      csv << ["Nome","Data de Nascimento","cpf"]
      inscriptions.active.joins(:student).order('LOWER(name)').each do |inscription|
        cpf = if inscription.student.cpf_missing
                inscription.student.cpf if !responsible_cpf_missing  
              else
                inscription.student.cpf
              end
        csv << [inscription.student.name,inscription.student.birthdate.strftime("%d/%m/%Y"),cpf ]
      end
    end
  end

  def students
    id = 0
    students = []
    inscriptions.order(:student_id).each do |inscription|
      if inscription.student_id != id
        students.push(inscription.student)
        id = inscription.student_id
      end
    end
    students
  end

  def students_active
    id = 0
    students = []
    inscriptions.order(:student_id).active.each do |inscription|
      if inscription.student_id != id
        students.push(inscription.student)
        id = inscription.student_id
      end
    end
    students
  end
  
  def students_evaded
    id = 0
    array =[]
     inscriptions.order(:student_id).where(student_status: "desisted").each do |inscription|
       if inscription.student_id != id
         array.push(inscription)
         id = inscription.student_id
       end
     end
    array
  end

  def update_lessons
    if saved_change_to_start? 
      if changes[:start][0] < changes[:start][1]
        Academic::Lesson.joins(classroom_subject: :classroom).where(classrooms:{school_year_id: id}).where('day < ?', start).each do |lesson|
          lesson.destroy
        end
      else
        Academic::ClassroomSubject.joins(:classroom).where(classrooms: {school_year_id: id}).each do |cs|
          generate_lesson(cs, start, final)
        end
      end
    end

    if saved_change_to_final?
      if changes[:final][0] < changes[:final][1]
        Academic::ClassroomSubject.joins(:classroom).where(classrooms: {school_year_id: id}).each do |cs|
          generate_lesson(cs, start, final)
        end
      else
        Academic::Lesson.joins(classroom_subject: :classroom).where(classrooms:{school_year_id: id}).where('day > ?', final).each do |lesson|
          lesson.destroy
        end
      end
    end
  end

  private
    def generate_lesson(classroom_subject, day_start, day_final)
      days = {
        0 => false,  # Domingo
        1 => classroom_subject.lesson_on_monday,
        2 => classroom_subject.lesson_on_tuesday,
        3 => classroom_subject.lesson_on_wednesday,
        4 => classroom_subject.lesson_on_thursday,
        5 => classroom_subject.lesson_on_friday,
        6 => false  # Sábado
      }

      reference_day = day_start

      while reference_day <= day_final
        if days[reference_day.wday] and Academic::Lesson.find_by(classroom_subject: classroom_subject, day: reference_day) == nil
          Academic::Lesson.create(classroom_subject_id: classroom_subject.id, day: reference_day)
        end
        reference_day += 1.day
      end
    end
    
    def find_teacher_of_leveled_subject classroom
       subject = classroom.subjects.find_by(leveled: true)
       return 'N/A'  if !subject.present?
       classroom.classroom_subjects.find_by(subject_id: subject.id).teacher.user.name
    end

    def translate_situation situation
      return 'Estudando' if situation == 'student'
      return 'Aprovado' if situation == 'approved'
      return 'Participante' if situation == 'participant'
      return 'Desistente' if situation == 'desisted'
      return 'Evadiu' if situation == 'evaded'
      return 'Reprovado por Falta' if situation == 'lack_of_lesson'
    end

    def inscription_level_name subject_level_id
      subject_level = Academic::SubjectLevel.find_by(id: subject_level_id)
      return if subject_level_id.nil?
      "#{subject_level.subject.name} - #{subject_level.name}" 
    end

    def cant_be_inside_another_school_year
      # Uso de Função Anônima para reaproveitar código.
      error = lambda do
        errors.add('base', 'Um Período Letivo não pode estar dentro de outro.')
      end

      # A Lógica por trás dessa validação consiste na necessidade de não haver um período
      # dentro de outro. Isso inclui casos em que apenas um "pedaço" do período é sobreposto
      # (Situação que é verificada pelos 2 blocos de código seguintes) ou o caso de um período
      # estar totalmente contido por outro (situação verificada no último bloco de código).

      school_years_start = Academic::SchoolYear.where('final > ?', start);
      
      school_years_start.each do |school_year|
        if school_year.start < start && school_year.id != id
          return error.call
        end
      end

      school_years_final = Academic::SchoolYear.where('final > ? AND start < ?', self.final, self.final);
      school_years_final.each do |school_year|
        if school_year.start < self.final && school_year.id != id
          return error.call
        end
      end

      school_years_inside = Academic::SchoolYear.where('start > ? AND final < ?', start, self.final)
      if school_years_inside.any? && school_year.id != id
        return error.call
      end
    end

    def year_should_be_valid
      return if final.nil? || start.nil?
      errors.add('final',' é invalido')if final.year > 3000
      errors.add('start',' é invalido')if start.year > 3000
    end
end
