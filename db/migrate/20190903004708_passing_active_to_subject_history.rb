class PassingActiveToSubjectHistory < ActiveRecord::Migration[5.1]
  def up
    add_column :subject_histories, :show, :boolean, default: true
    Academic::SubjectHistory.all.each do |sh|
      sh.update_attributes(show: Academic::StudentClassroomSubject.find_by(inscription: sh.inscription, classroom_subject: sh.classroom_subject).show)
    end

  end
  def down
    remove_column :subject_histories, :show, :boolean
  end 
end
