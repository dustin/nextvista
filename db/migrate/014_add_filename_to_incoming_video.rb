class AddFilenameToIncomingVideo < ActiveRecord::Migration
  def self.up
    add_column :incoming_videos, :filename, :string
  end

  def self.down
    remove_column :incoming_videos, :filename
  end
end
