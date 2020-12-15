class AddOwneremailToSubject < ActiveRecord::Migration[5.2]
  def change
    add_column :subjects, :owneremail, :string
  end
end
