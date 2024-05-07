require 'csv'

class Student < ApplicationRecord

  has_many :student_social_programs
  has_many :social_programs, :through => :student_social_programs

  belongs_to :city
  belongs_to :neighborhood
  belongs_to :school
  belongs_to :state

  has_one :vocational_interview
  has_many :inscriptions, class_name: 'Academic::Inscription'
  has_many :classrooms, through: :inscriptions, class_name: 'Academic::Classroom'

  has_many :presences, class_name: 'Academic::Presence'
  
  has_many :family_members

  has_one :service_sheet

  has_many :program_aids
  has_many :assistance_programs, :through => :program_aids

  has_many :expenses

  has_many :labor_markets

  has_many :occurrences

  validates :year, numericality: true, length: {is: 4}
  validates :name, length: { in: 1..70 }
  validates :medication, length: { in: 0..500 }
  validates :sub_neighborhood, length: { in: 0..20 }
  validates :number_residents, :numericality => { :greater_than_or_equal_to => 0 }
  validates :project_indication_description, length: { in: 0..50 }
  validates :school, length: { in: 1..70 }
  validates :annotations, length: { in: 0..5000 }
  validates :nis, length: { in: 0..11 }
  validates :birthdate, :presence => true
  validates_cpf :cpf, allow_blank: true
  validates_cpf :father_cpf, allow_blank: true
  validates_cpf :mother_cpf, allow_blank: true
  validates_cpf :responsible_cpf, allow_blank: true

  mount_uploader :photo, PictureUploader

  enum status: {
    renewed: 0,
    ingressant: 1,
    desisted: 2,
    reentry: 3,
    wait: 4,
    evaded: 5
  }

  enum sex: {
    male: 0,
    female: 1,
    other: 2
  }

  enum ethnicity: {
    "Branco": 0,
    "Pardo": 1, 
    "Preto": 2,
    "Amarelo": 3,
    "Indígena": 4,
    "Não declarado": 5
  }
  
  enum project_indication: {
    "Indicação": 0,
    "Mídia": 1,
    "Instituição": 2,
    "Não Informado": 3,
    "Outros": 4
  }

  enum school_shift: {
    morning: 0,
    afternoon: 1,
    night: 2,
    integral: 3
  }
  
  enum grade: {
    "Fundamental I": 0,
    "Fundamental II": 1,
    "Ensino Médio": 2,
    "Educação de Jovens e Adultos": 3,
    "Curso Técnico": 4,
    "Ensino Superior": 5,
    "Pós Graduação": 6
  }

  enum completed: {
    studying: 0,
    finished: 1,
  }
  

  before_create :generate_registration_number
  around_save :check_school_relation
  before_destroy :decrement_school
  before_save :add_renewed_date

  before_save :add_renewed_bool_to_inscriptions

  #Antes de salvar, verificar se o status do estudante foi alterado para alterá-lo na inscrição
  after_save :add_status_to_inscription

  def self.to_cpf_csv
    attributes = %w{name cpf responsible_cpf birthdate}

    CSV.generate(headers: true) do |csv|
      csv << ["Nome", "CPF", "Nascimento"]
      inscriptions = Academic::SchoolYear.current.inscriptions.where.not(student_status: "evaded").where.not(student_status: "desisted").active
      student_id = 0
      inscriptions.joins(:student).order('LOWER(name)').each do |inscription|
        next if inscription.student.id == student_id 
        student_id = inscription.student.id
        cpf = inscription.student.cpf.present? ? inscription.student.cpf : inscription.student.responsible_cpf
        csv << [inscription.student.name, cpf, I18n.l(inscription.student.birthdate)]
      end
    end
  end

  def self.consecutive_misses(list)
    counter = 0
    a = list.first.lesson.ordenation
    list.includes(:lesson).order('lessons.ordenation').each do |miss|
      if miss.lesson.ordenation == a
        return false if miss.lesson.ordenation.nil?
        counter += 1
        a = miss.lesson.ordenation + 1
      else
        counter = 0
      end

      if counter == 3
        return true
      end
    end
    return false
  end

  def add_renewed_date
    #Se o status do usuário tiver sido modificado para renovado...
    #Deve-se modificar o atributo "renewable_date" da inscrição dele em todas as turmas para a data do dia atual
    if self.status_changed?
      self.changes["status"][1] == "renewed"
      self.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)).each do |inscription|
        inscription.renewable_date = Time.now.to_date.to_s
        inscription.save
      end
    end
  end

  def add_renewed_bool_to_inscriptions
    if self.status_changed?
      if self.changes["status"][1] == "renewed"
        self.inscriptions.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)).each do |inscription|
          inscription.renewed_bool = true
          inscription.save
        end
      end
    end
  end

  def add_status_to_inscription
    inscriptions.joins(:classroom).where("classroom.school_year_id" == Academic::SchoolYear.current.id).active.each do |i|
      if i.student_status != status
        i.update_attributes(student_status: status, modification_day_status: Time.now.to_date.to_s)
      end
    end
  end

  def self.absents
    absents = []
    
    subject_histories = Academic::SubjectHistory.where(classroom_subject: Academic::ClassroomSubject.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.where(status: 1))))
    subject_histories.each do |subject_history|
      if subject_history.date_resolved_absence != nil
        date = subject_history.date_resolved_absence.to_date
        if Academic::SchoolYear.find_by(status: 1) != nil
          if date < Academic::SchoolYear.find_by(status: 1).start
            date = Academic::SchoolYear.find_by(status: 1).start
          end
        end
      else
        date = "2000-01-01".to_date
        if Academic::SchoolYear.find_by(status: 1) != nil
          if date < Academic::SchoolYear.find_by(status: 1).start
            date = Academic::SchoolYear.find_by(status: 1).start
          end
        end
      end

      #Declaração da variavel para saber se ja existe algo caso de falta do estudante na lista de 'faltantes'
      equal = false
      #Para cada estudante 'faltante' na lista...
      absents.each do |abs|
        #Se houver algum estudante na lista igual ao que será adicionado, modificar a variavel 'equal' para true
        if(subject_history.inscription.student.id == abs[:student_id])
          equal = true
        end
      end

      #Se não tiver nenhuma ocorrencia de falta desse estudante ainda, verifique as condições de falta e adicione-o na lista
      if equal == false

      user_absences = subject_history.inscription.student.presences.where(lesson: Academic::Lesson.where("day > ?", date).where(classroom_subject: subject_history.classroom_subject)).where("situation = ?", 2) #number 2 is absent

        if (user_absences.length >= 6) || (user_absences.length >= 3 && user_absences.length < 6 && consecutive_misses(user_absences)) 
          
          absent = {
            :student => subject_history.inscription.student.name,
            :student_id => subject_history.inscription.student.id, 
            :absences => amount_misses(subject_history.inscription.student), #Rever
            :email => subject_history.inscription.student.email,
            :phone => subject_history.inscription.student.phone,
            :mobile_phone => subject_history.inscription.student.mobile_phone,
            :subject => subject_history.classroom_subject.subject,
            :subject_history_id => subject_history.id
          }

          #Só adiciona se o aluno tiver o status diferente de Evadido ou Desistente
          if Student.find(absent[:student_id]).status != 'desisted' && Student.find(absent[:student_id]).status != 'evaded'
            absents.push(absent)
          end
        end

      end

      
    end
    return absents    
  end

  def absences
    self.presences.where("situation = ?", 2).order(lesson_id: :asc)
  end

  def self.amount_misses(student)
    #Variavel que armazena a quantidade de faltas do estudante
    amount = 0
    #Array que guarda por quais classroom_subjects, já foi passada, para nao adicionar falta repetida na contagem
    array_classroom_subject_ids = []

    #Para cada inscrição do estudante
    student.inscriptions.each do |insc|
      #Para cada SubjectHistory de cada inscrição...
      insc.subject_histories.each do |sub_hist|
        #Se as faltas desse aluno, nessa disciplina já tiverem sido resolvidas...
        if(sub_hist.date_resolved_absence != nil)
          date = sub_hist.date_resolved_absence
          #Se houver um periodo letivo atual...
          if Academic::SchoolYear.find_by(status: 1) != nil
            #Se a falta tiver sido resolvida em periodos passados...
            #Deve-se pegar apenas as presenças a partir do primeiro dia do periodo letivo atual
            if date < Academic::SchoolYear.find_by(status: 1).start
              date = Academic::SchoolYear.find_by(status: 1).start
            end
          end
        #Se as faltas desse aluno, nessa disciplina ainda não tiverem sido resolvidas...
        else
          date = "2000-01-01"
          #Caso haja um periodo letivo atual...
          if Academic::SchoolYear.find_by(status: 1) != nil
            date = Academic::SchoolYear.find_by(status: 1).start
          end
        end

        #Flag para saber se ja acrescentamos a quantidade de falta daquele aluno naquele 'classroom_subject' (ou curso)
        exists = false
        #Para cada classroom_subject que ja passamos, verifique se é igual...
        array_classroom_subject_ids.each do |id|
          if sub_hist.classroom_subject.id == id
            exists = true
          end
        end
        #Se ainda nao tivermos passado por ele
        if exists == false
          #Acrescenta esse classroom_subject na lista
          array_classroom_subject_ids.push(sub_hist.classroom_subject.id)
          #E soma as faltas desse aluno nesse curso
          amount += student.absences.where(lesson: Academic::Lesson.where('day > ?', date).where(classroom_subject: sub_hist.classroom_subject)).length
        end

      end
    end
    #Retorna a quantidade de faltas do estudante
    return amount
  end
  
  def pedant?
    rg_missing and cpf_missing and responsible_rg_missing and responsible_cpf_missing and address_proof_missing and term_signed_missing and school_declaration_missing and medical_certificate_missing and birth_certificate_missing and historic_missing
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def active_inscription 
    Academic::Inscription.joins(:classroom).find_by(
      "active = ? and classrooms.school_year_id = ? and student_id = ?",
      true, Academic::SchoolYear.current.id, self.id
    )
  end

  private

    def generate_registration_number
      reg_number = RegistrationNumber.find_by(year: year, semester: semester)

      if reg_number.nil?
        reg_number = RegistrationNumber.create(year: year, semester: semester, number_students: 1)
      end

      number = reg_number.number_students.to_s
      while number.length < 3
        number.prepend('0')
      end

      self.registration_number = "#{year}#{semester}#{number}"
      reg_number.update(number_students: reg_number.number_students+1)
    end
  
    def check_school_relation
      if self.school_id_changed?
        old_school = School.find_by(id: school_id_was)
        new_school = School.find_by(id: school_id)

        yield

        if old_school.present?
          old_school.number_students -= 1
          old_school.save
        end

        if new_school.present?
          new_school.number_students += 1
          new_school.save
        end
      else
        yield
      end
    end

    def decrement_school
      student_school = self.school
      student_school.number_students -= 1
      student_school.save
    end
end
