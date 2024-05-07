class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.references :city, foreign_key: true
      t.references :neighborhood, foreign_key: true
      t.references :school, foreign_key: true
      t.references :state, foreign_key: true
      t.string :year
      t.string :semester
      t.string :photo
      t.string :name
      t.date :birthdate
      t.integer :sex
      t.integer :ethnicity
      t.string :nationality
      t.string :naturalness
      t.string :rg
      t.string :issuing_agency
      t.date :issuing_date
      t.string :cpf
      t.string :address
      t.string :cep
      t.string :sub_neighborhood
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.integer :project_indication
      t.text :project_indication_description
      t.text :medication
      t.integer :school_shift
      t.integer :grade
      t.string :father_name
      t.string :father_cpf
      t.string :father_email
      t.string :father_phone
      t.string :mother_name
      t.string :mother_cpf
      t.string :mother_email
      t.string :mother_phone
      t.string :responsible_name
      t.string :responsible_cpf
      t.string :responsible_email
      t.string :responsible_phone
      t.integer :number_residents
      t.decimal :family_income
      t.string :nis
      t.text :annotations
      t.boolean :working
      t.string :company

      t.timestamps
    end
  end
end
