class CreateIncomingVideos < ActiveRecord::Migration
  def self.up
    create_table :incoming_videos do |t|
      t.string :title, :null => false
      t.string :descr, :null => false
      t.string :long_descr, :null => false
      t.integer :submitter_id, :null => false
      t.integer :language_id, :null => false
      t.integer :size, :null => false
      t.integer :state, :default => 0
      t.integer :remote_id
      t.timestamps
    end
  end

  def self.down
    drop_table :incoming_videos
  end
end
