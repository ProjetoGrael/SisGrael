class CreateLaborMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :labor_markets do |t|
      t.integer :year
      t.references :student, foreign_key: true
      t.date :date_closure
      t.date :date_start
      t.date :date_exit
      t.string :company
      t.string :company_address
      t.string :student_occupation_area
      t.string :student_office
      t.string :contact_name
      t.string :contact_office
      t.string :contact_email
      t.string :company_phone_number

      t.timestamps
    end
  end
end
