class Academic::Teacher < ApplicationRecord
  has_many :teacher_skills, dependent: :destroy
  has_many :subjects, through: :teacher_skills
  has_many :classroom_subjects
  has_many :classrooms, through: :classroom_subjects
  belongs_to :user

  validates :birth, presence: true
  validates_cpf :cpf

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

  def name
    user.name if user.present?
  end

  def email
    user.email if user.present?
  end

  def photo
    user.picture if user.present?
  end

  def frequency_list_pendant
    sum = 0
    #Descobre todos os cursos que o professor da aula
    classroom_subjects.where(classroom: Academic::Classroom.where(school_year: Academic::SchoolYear.current)).each do |cs|
      #Pega todas as aulas de cada curso
      cs.lessons.each do |lesson|
        #Caso passe de 10, saia do loop...
        if sum == 10
          break
        end
        #Descobre o número de presenças que não foram lançadas em cada aula
        number_of_presences_not_launched = lesson.presences.where(situation: 0).length
        #Se tiver pelo menos uma presença não lançada, soma 1 ao "sum", porque a pauta está incompleta
        if number_of_presences_not_launched > 0
          sum += 1
        end
      end
    end
    #Se tem pelo menos uma pauta incompleta, retorna um objeto com true e a soma de quantas pautas está incompleta
    if sum > 0
      return { "boolean": true, "sum": sum }
    #Se não tem nenhuma pauta incompleta, retorna um objeto com false e a soma é 0
    else
      return { "boolean": false, "sum": 0 }
    end
  end

  def self.active
    all.where(active: true)
  end
end
