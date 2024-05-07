class AddWorkloadToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :workload, :integer
  end
end
