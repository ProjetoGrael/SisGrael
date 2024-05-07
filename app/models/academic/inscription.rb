class Academic::Inscription < ApplicationRecord
  belongs_to :student
  belongs_to :classroom
  has_many :subject_histories,  dependent: :destroy
  has_many :student_classroom_subjects, dependent: :destroy

  validate :inscription_must_be_unique, on: :create
  validate :school_year_must_be_active

  validate :check_student, :on => :create
  after_create :create_presences_for_student
  after_create :create_student_classroom_subject
  after_destroy :delete_presences_of_student
  # after_update :inactive_delete
  
  #Antes de criar, deve-se verificar se já existem inscrições renovadas nesse periodo, para atualizar o atributo renewable_date
  before_create :update_renewable_date

  #Ao criar uma inscrição, deve-se atualizar o student_status de acordo com o status do aluno
  before_create :update_student_status

  #Antes de criar, deve-se verificar se já existem inscrições renovadas nesse período para atualizar o atributo renewed_bool
  before_create :update_renewed_bool

  enum situation: {
    studying: 0,
    approved: 1,
    participant: 2,
    lack_of_lesson: 3
  }

  #Caso haja inscrições no periodo letivo da criação da inscrição, ele atualiza o renewed_bool de acordo com o valor dos que ja existem
  def update_renewed_bool
    if self.student.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)) != []
      self.renewed_bool = self.student.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)).first.renewed_bool
    end
  end

  #Antes de criar uma nova inscrição, verificar se o estudante tem alguma inscrição no periodo letivo atual
  # e se tiver, fazer com que o atributo "renewable_date" seja igual a
  def update_renewable_date
    if self.student.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)) != []
      self.renewable_date = self.student.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)).first.renewable_date        
    end
  end

  def get_semester
    school_year = self.classroom.school_year
    start_date = school_year.start
    start_month = start_date.strftime("%m").to_i

    semester = start_month >= 6 ? 2 : 1
    year = start_date.strftime("%Y")

    "#{semester}º semestre de #{year}"
  end

  def self.active
    all.where(active: true)
  end

  def evaded_or_desisted?
    self.student.status == "evaded" || self.student.status == "desisted"
  end

  def self.not_evaded
    all.where(active:true, student_status: ["renewed","ingressant","reentry","wait"])
  end

  private

    def update_student_status
      self.student_status = self.student.status
      self.modification_day_status = Time.now.to_date.to_s
    end

    def inactive_delete
      return if active
      delete_presences_of_student
      subject_histories.destroy_all
      student_classroom_subjects.destroy_all
    end


    def create_presences_for_student
      classroom.classroom_subjects.each do |class_sub|
        class_sub.lessons.each do |lesson|
          Academic::Presence.create(
            student_id: student.id,
            lesson_id: lesson.id
          )
        end
      end
    end

    def create_student_classroom_subject
      classroom.classroom_subjects.each do |classroom_subject|
        Academic::StudentClassroomSubject.create(inscription_id: id, classroom_subject_id: classroom_subject.id)
      end
    end

    def delete_presences_of_student
      classroom.classroom_subjects.each do |class_sub|
        Academic::Presence.joins(:lesson).where(
          lessons: { classroom_subject_id: class_sub.id },
          student_id: student.id
        ).each { |presence| presence.destroy if presence.lesson.day > Date.today}
      end
    end

    def school_year_must_be_active
      if classroom.school_year.inactive?
        errors.add(:base, 'Período Letivo precisa estar ativo para alterações.')
      end
    end

    def inscription_must_be_unique
      same_inscription = Academic::Inscription.active.find_by(student_id: student_id, classroom_id: classroom_id)
      if same_inscription.present?
        errors.add(:base, 'Aluno já adicionado a esta turma!')
      end
    end

    def check_student
      errors.add(:base, 'Aluno desistente')if student.status == "desisted"
    end
end
