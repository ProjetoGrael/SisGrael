class Academic::Presence < ApplicationRecord
  belongs_to :lesson
  belongs_to :student

  enum situation: {
    not_launched: 0,
    present: 1,
    later: 4,
    absent: 2,
    justified_absence: 3
  }
  after_update :all_presences_done

  def inscription
    Academic::Inscription.find_by(student_id: student_id, classroom_id: lesson.classroom_subject.classroom_id, active: true)
  end

  private
    def all_presences_done
      if lesson.presences.where(situation: "not_launched").empty?
        lesson.update_attributes(done: true)
      else
        lesson.update_attributes(done: false)
      end
    end
end
