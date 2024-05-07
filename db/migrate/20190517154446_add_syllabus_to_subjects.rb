class AddSyllabusToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :syllabus, :string
  end
end
