class AddWorkloadToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :workload, :integer
  end
end
