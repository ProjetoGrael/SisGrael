class ProgramAid < ApplicationRecord
  belongs_to :student
  belongs_to :assistance_program

  validates :assistance_program_id, uniqueness: { scope: [:student_id]}
  validates :value, presence: true

end
