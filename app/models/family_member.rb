class FamilyMember < ApplicationRecord
  belongs_to :student
  belongs_to :service_sheet, optional: true

  enum scholarity: {
    "Ensino Fundamental incompleto": 0,
    "Ensino Fundamental completo": 1,
    "Ensino Médio incompleto": 2,
    "Ensino Médio completo": 3,
    "Ensino Superior incompleto": 4,
   "Ensino Superior completo": 5
  }

  validates :scholarity, :presence => true
  validates :age, :numericality => true, :presence => true
  validates :occupation, :presence => true
  validates :income, :numericality => true, :presence => true
end
