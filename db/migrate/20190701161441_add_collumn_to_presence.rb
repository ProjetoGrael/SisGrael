class AddCollumnToPresence < ActiveRecord::Migration[5.1]
  def change
    add_column :presences, :participation, :integer
    add_column :presences, :behavior, :integer
    add_column :presences, :learning, :integer
  end
end
