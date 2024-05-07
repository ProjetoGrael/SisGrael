class Academic::Subject < ApplicationRecord
  attr_accessor :program

  has_many :teacher_skills, dependent: :destroy
  has_many :teachers, through: :teacher_skills
  has_many :classroom_subject
  has_many :classrooms, through: :classroom_subject
  has_many :subject_levels, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  mount_uploader :syllabus, SyllabusUploader  

  #Toda vez que cria ou atualiza a matéria, ele tenta atualizar os atributos "professionalized", "environmental", "sport" no BD
  before_create :update_program_attributes
  before_update :update_program_attributes

  #Função que atribui a partir da variavel program (que vem de um select) para os devidos atributos no banco de dados
  def update_program_attributes
    if program != nil and program != ""
      self.professionalized = false
      self.environmental = false
      self.sport = false
      if program == "professionalized"
        self.professionalized = true
      end
      if program == "environmental"
        self.environmental = true
      end
      if program == "sport"
        self.sport = true
      end
    end
  end
end
