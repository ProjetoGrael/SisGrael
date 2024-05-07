class AddSchoolYearToOccurrence < ActiveRecord::Migration[5.1]
  def change
    add_reference :occurrences, :school_year, foreign_key: true
  end
end
