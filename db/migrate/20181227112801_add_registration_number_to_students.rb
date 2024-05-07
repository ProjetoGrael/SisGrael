class AddRegistrationNumberToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :registration_number, :string
  end
end
