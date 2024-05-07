class Academic::Classroom < ApplicationRecord
  belongs_to :school_year
  has_many :classroom_subjects, dependent: :destroy
  has_many :teachers, through: :classroom_subjects
  has_many :subjects, through: :classroom_subjects
  has_many :inscriptions, class_name: 'Academic::Inscription', dependent: :destroy
  has_many :students, through: :inscriptions
  has_one :main, class_name: "Academic::ClassroomSubject"

  validates :fantasy_name, presence: true
  validate :school_year_must_be_active
  def environmental?
    return false if subjects.where(environmental: true).empty?
    return true
  end

  def self.get_environmental
    list = []
    all.each do |classroom|
      list.push(classroom) if classroom.environmental?
    end
    list
  end

  def sport?
    return false if subjects.where(sport: true).empty?
    return true
  end

  def self.get_sport
    list = []
    all.each do |classroom|
      list.push(classroom) if classroom.sport?
    end
    list
  end


  def professionalized?
    return false if subjects.where(professionalized: true).empty?
    return true
  end

  def self.get_professionalized
    list = []
    all.each do |classroom|
      list.push(classroom) if classroom.professionalized?
    end
    list
  end

  private

    def school_year_must_be_active
      if school_year.inactive?
        errors.add(:school_year, 'precisa estar ativo para alterações na turma.')
      end
    end
end
