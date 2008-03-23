class AddMetaToIncomingVideos < ActiveRecord::Migration
  def self.up
    add_column :incoming_videos, :meta, :text
  end

  def self.down
    remove_column :incoming_videos, :meta
  end
end
