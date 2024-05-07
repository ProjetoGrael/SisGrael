class VocationalInterview < ApplicationRecord
    belongs_to :student
    ### Não há referencia no schema
    # belongs_to :user 

    after_save :save_ethnicity_in_student

    #after_save para alterar a etnia do estudante no model Student, caso tenha sido alterado no form de entrevista profissionalizante
    def save_ethnicity_in_student
        if self.saved_change_to_ethnicity?
            self.student.ethnicity = saved_change_to_ethnicity[1]
            self.student.save
        end
    end

    enum ethnicity: {
        "Branco": 0,
        "Pardo": 1,
        "Preto": 2,
        "Amarelo": 3,
        "Indígena": 4,
        "Não declarado": 5
    }

    enum last_attended_educational_institution: {
        "Pública": 0,
        "Privada": 1,
        "Privada com bolsa": 2
      }


    enum motivation: {
        "Escolhas pessoais": 0,
        "Disponibilidade de vaga no mercado de trabalho": 1,
        "Esporte": 2,
        "Influência de familiares/terceiros": 3,
        "Outra motivação": 4
    }


    enum project_access: {
        "Transporte público": 0,
        "Transporte particular": 1,
        "Transporte privado": 2
    }

    enum number_transport: {
        "1": 0,
        "2": 1,
        "Mais de 2": 2
    }

    enum family_life: {
        "harmonioso": 0,
        "com diálogo fácil": 1,
        "com diálogo difícil": 2,
        "conflituoso": 3
    }

    enum urban_infrastructure: {
        "Sim": 0,
        "Não": 1,
        "Parcial": 2
    }

end
