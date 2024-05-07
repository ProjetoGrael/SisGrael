class AddStudentStatusToInscription < ActiveRecord::Migration[5.1]
  def change
    add_column :inscriptions, :student_status, :string
  end
end
