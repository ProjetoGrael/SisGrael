class AddInfoResponsibleForStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :kinship, :string
    add_column :students, :father_responsible, :boolean, default: false

    add_column :students, :mother_responsible, :boolean, default: false
    add_column :students, :student_responsible, :boolean, default: false
    add_column :students, :other_relative_responsible, :boolean, default: true
  end
end
