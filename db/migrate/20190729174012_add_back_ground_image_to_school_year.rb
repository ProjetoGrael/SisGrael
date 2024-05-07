class AddBackGroundImageToSchoolYear < ActiveRecord::Migration[5.1]
  def change
    add_column :school_years, :background_image, :string
  end
end
