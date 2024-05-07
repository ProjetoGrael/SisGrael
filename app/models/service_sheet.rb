class ServiceSheet < ApplicationRecord
  belongs_to :student
  has_many :family_members
  accepts_nested_attributes_for :family_members, allow_destroy: true

  enum marital_status: {
    "Casado": 0,
    "Solteiro": 1,
    "Separado": 2,
    "Divorciado": 3,
    "Viúvo": 4
  }

  enum working_situation: {
    "": 0,
    "CLT": 1,
    "Contrato de trabalho": 2,
    "Autônomo": 3,
    "Desempregado": 4,
    "Outra situação de trabalho": 5,
  }

  enum residence_status: {
    "Alugada": 0,
    "Própria": 1,
    "Cedida": 2,
    "Invasão": 3,
    "Assentamento": 4,
    "Financiada": 6,
    "Outra situação habitacional": 7
  }

  enum kind_of_residence: {
    "Madeira": 0,
    "Alvenaria": 1,
    "Misto": 2,
    "Outro tipo de residência": 3
  }



end
