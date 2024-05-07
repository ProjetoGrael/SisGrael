class AddInfoToSubjectHistory < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        subjecthistories = Academic::SubjectHistory.all
        subjecthistories.each do |subjecthistory|
         
          student_id = subjecthistory.student_id
          classroom_id = subjecthistory.classroom.id
          inscription = Academic::Inscription.find_by!(student_id: student_id, classroom_id: classroom_id)
          
          subjecthistory.update_attributes!(inscription_id: inscription.id)
        end

      end

      dir.down do
        subjecthistories = Academic::SubjectHistory.all
        subjecthistories.each do |subjecthistory|
          subjecthistory.update_attributes(inscription_id: nil)
        end
      end
    end
  end
end
