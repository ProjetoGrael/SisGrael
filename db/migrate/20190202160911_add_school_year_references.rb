class AddSchoolYearReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :classrooms, :school_year, foreign_key: true
    add_reference :courses, :school_year, foreign_key: true
  end
end
