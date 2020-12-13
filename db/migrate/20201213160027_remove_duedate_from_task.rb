class RemoveDuedateFromTask < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :duedate, :date
  end
end
