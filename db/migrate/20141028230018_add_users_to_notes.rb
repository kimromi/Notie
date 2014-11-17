class AddUsersToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :user_id, :string
    add_column :notes, :auth, :string
  end
end
