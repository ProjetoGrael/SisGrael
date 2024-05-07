class InscriptionError < StandardError; end

class Academic::SubjectHistory < ApplicationRecord
  belongs_to :inscription
  belongs_to :classroom_subject
  belongs_to :subject_level, optional: true

  # Tanto final_council e partial_council sao decimais mas sao mostrado no fronte como letras de A ate D
  # que corresponde as valor inteiros de 1 ate 4
  def self.create_from_inscription(inscription, leveled_classroom_subjects)
    begin
      Academic::SubjectHistory.transaction do
        inscription.classroom.classroom_subjects.each do |classroom_subject|
          if classroom_subject.subject.leveled
            level_hash = leveled_classroom_subjects[classroom_subject.id.to_s]
            level_id = level_hash[:subject_level_id] if level_hash.present?

            if level_hash.nil? || level_id.nil?
              raise InscriptionError, "Ocorreu um erro, tente novamente."
            end

            Academic::SubjectHistory.create!(
              inscription_id: inscription.id,
              classroom_subject_id: classroom_subject.id,
              subject_level_id: level_id
            )
          else
            Academic::SubjectHistory.create!(
              inscription_id: inscription.id,
              classroom_subject_id: classroom_subject.id
            )
          end
        end
      end
      # Se tudo deu certo e nenhum erro foi levantado:  
      return true
    rescue InscriptionError
      return false
    end
  end
  #Tabela de controle
  def is_valid?
    Academic::StudentClassroomSubject.find_by(inscription_id: inscription.id, classroom_subject_id: classroom_subject.id).show
  end

  def full_name
    subject.name + if subject_level.present?
      "- #{subject_level.name}"
    else
      ""
    end
  end
  def school_year
    classroom.school_year if classroom.present?
  end
  
  def classroom
    classroom_subject.classroom if classroom_subject.present?
  end

  def subject
    classroom_subject.subject if classroom_subject.present?
  end

  def self.active
    all.select{ |i| Academic::StudentClassroomSubject.find_by(inscription_id: i.inscription.id, classroom_subject_id: i.classroom_subject.id).show}
  end
  def mean
    return ((partial_counsel+ final_counsel)/2).round if partial_counsel.present? and final_counsel.present?
  end
  def teacher
    classroom_subject.teacher if classroom_subject.present?
  end
end
