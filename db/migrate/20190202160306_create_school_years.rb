class CreateSchoolYears < ActiveRecord::Migration[5.1]
  def change
    create_table :school_years do |t|
      t.string :name
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
