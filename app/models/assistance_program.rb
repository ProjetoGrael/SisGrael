class AssistanceProgram < ApplicationRecord
    has_many :program_aids, dependent: :delete_all
    has_many :students, :through => :program_aids

    validates :name, presence: true
    validates_uniqueness_of :name
    
    
end
