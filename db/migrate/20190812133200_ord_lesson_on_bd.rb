class OrdLessonOnBd < ActiveRecord::Migration[5.1]
  def change
    Academic::ClassroomSubject.all.each{|classroomsubject| classroomsubject.ord_lesson }
  end
end
