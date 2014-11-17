class RenameColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :shortcut, :key_shortcut
  end
end
