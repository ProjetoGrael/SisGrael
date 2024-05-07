class UpdateStudentStatusCurrentSchoolYear < ActiveRecord::Migration[5.1]
  def change
    # Academic::SchoolYear.current.inscriptions.each do |inscription|
    #   if(inscription.student_status == nil)
    #     inscription.student_status = inscription.student.status
    #     inscription.modification_day_status = Time.now.to_date.to_s
    #     inscription.save
    #   end
    # end
  end
end
