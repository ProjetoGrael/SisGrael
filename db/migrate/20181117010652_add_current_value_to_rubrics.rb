class AddCurrentValueToRubrics < ActiveRecord::Migration[5.1]
  def change
    change_table :rubrics do |t|
      t.decimal :current_value, precision: 20, scale: 2
    end
  end
end
