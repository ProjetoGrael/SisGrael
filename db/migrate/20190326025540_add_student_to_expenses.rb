class AddStudentToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_reference :expenses, :student, foreign_key: true
  end
end
