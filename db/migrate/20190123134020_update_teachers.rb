class UpdateTeachers < ActiveRecord::Migration[5.1]
  def change
    change_table :teachers do |t|
      t.string :photo
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
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.string :partner_name
      t.string :partner_cpf
      t.string :partner_email
      t.string :partner_phone
    end
  end
end
