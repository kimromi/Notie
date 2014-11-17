class ChangeDefaultColumnToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :key_shortcut, true
  end
end
