class CreateFreeTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :free_times do |t|
      t.date :day
      t.time :start_at
      t.time :finish_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
