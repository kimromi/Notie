class AddUidToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :uid, :string, :null => true, :limit => 6
  end
end
