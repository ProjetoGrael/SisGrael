class CreateServiceSheets < ActiveRecord::Migration[5.1]
  def change
    create_table :service_sheets do |t|
      t.references :student, foreign_key: true
      t.string :dwell_time_address
      t.integer :marital_status
      t.boolean :disabled_person
      t.boolean :has_documentation
      t.string :father
      t.string :mother
      t.integer :working_situation
      t.text :working_situation_other
      t.boolean :receives_benefit
      t.text :receives_benefit_wich
      t.decimal :family_income
      t.boolean :light
      t.decimal :light_value
      t.boolean :water
      t.decimal :water_value
      t.boolean :phone
      t.decimal :phone_value
      t.boolean :internet
      t.decimal :internet_value
      t.boolean :medication_expense
      t.decimal :medication_value
      t.boolean :iptu
      t.decimal :iptu_value
      t.boolean :food
      t.decimal :food_value
      t.boolean :other
      t.text :other_text
      t.string :dwell_time_city
      t.text :previously_resided_city
      t.integer :residence_status
      t.text :residence_status_text
      t.integer :kind_of_residence
      t.text :kind_of_residence_text
      t.integer :room_number
      t.boolean :medication
      t.text :medication_text
      t.boolean :psychiatric_treatment
      t.text :psychiatric_treatment_where
      t.boolean :deficiency_in_family
      t.text :deficiency_in_family_text
      t.text :deficiency_in_family_who
      t.text :health_more_info
      t.boolean :protective_measures
      t.text :protective_measures_text
      t.boolean :socio_educational_measure
      t.text :socio_educational_measure_text
      t.text :socio_educational_measure_when
      t.text :notes
      t.text :referrals
      t.string :responsible_technician

      t.timestamps
    end
  end
end
