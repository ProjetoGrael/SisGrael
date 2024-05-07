require_relative '20190302181104_create_academic_subject_levels'

class FixSubjectLevels < ActiveRecord::Migration[5.1]
  def change
    revert CreateAcademicSubjectLevels
  end
end
