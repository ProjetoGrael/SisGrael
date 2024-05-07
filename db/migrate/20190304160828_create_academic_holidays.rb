class CreateAcademicHolidays < ActiveRecord::Migration[5.1]
  def change
    create_table :holidays do |t|
      t.string :name
      t.date :day
      t.references :school_year, foreign_key: true

      t.timestamps
    end
  end
end
