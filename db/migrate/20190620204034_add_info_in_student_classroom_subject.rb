class AddInfoInStudentClassroomSubject < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        Academic::Inscription.all.each do |inscription|
          inscription.classroom.classroom_subjects.each do |classroom_subject|
             Academic::StudentClassroomSubject.create!(inscription_id: inscription.id, classroom_subject_id: classroom_subject.id)
          end
        end

      end
      dir.down do
        Academic::StudentClassroomSubject.all.destroy_all
      end
    end  
  end
end
