class AddKindToInterview < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :kind, :integer
  end
end
