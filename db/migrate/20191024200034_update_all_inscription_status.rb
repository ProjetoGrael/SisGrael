class UpdateAllInscriptionStatus < ActiveRecord::Migration[5.1]
  def change
    def change
      Academic::Inscription.all.each do |i|
        i.update_attributes(student_status: i.student.status)
      end
    end
  end
end
