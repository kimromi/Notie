class ChangeColumnToNote < ActiveRecord::Migration
  def self.up
    change_column :notes, :uid, :string, null: true, limit: 10
  end

  def self.down
    change_column :notes, :uid, :string, null: true, limit: 6
  end
end
