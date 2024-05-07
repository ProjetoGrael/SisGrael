class CreateRegistrationNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :registration_numbers do |t|
      t.string :year
      t.string :semester
      t.integer :number_students

      t.timestamps
    end
  end
end
