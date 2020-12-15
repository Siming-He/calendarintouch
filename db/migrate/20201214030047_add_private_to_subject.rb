class AddPrivateToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :private, :boolean
  end
end
