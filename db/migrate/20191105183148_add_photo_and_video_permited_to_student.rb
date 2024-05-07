class AddPhotoAndVideoPermitedToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :photo_and_video_permited, :boolean
  end
end
