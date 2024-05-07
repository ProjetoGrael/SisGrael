class RemoveCollumnsFromPresence < ActiveRecord::Migration[5.1]
  def change
      remove_column :presences, :behavior
      remove_column :presences, :learning
  end
end
