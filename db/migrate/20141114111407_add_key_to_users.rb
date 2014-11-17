class AddKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shortcut, :boolean
  end
end
