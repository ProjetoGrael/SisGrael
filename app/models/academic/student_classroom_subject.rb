class Academic::StudentClassroomSubject < ApplicationRecord
  belongs_to :inscription
  belongs_to :classroom_subject
  after_update :update_subject_history

  def self.get_student_classroom_subject(inscription, classroom_subject)
    inscription.student_classroom_subjects.find_by(classroom_subject_id: classroom_subject.id)
  end

  def update_subject_history
    Academic::SubjectHistory.find_by(inscription: inscription, classroom_subject: classroom_subject).update_attributes(show: show)
  end
end
