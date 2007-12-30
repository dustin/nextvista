class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.column :submitter_id, :integer, :null => false
      t.column :submit_date, :datetime, :null => false
      t.column :language_id, :integer, :null => false
      t.column :duration, :integer, :null => false
      t.column :title, :string, :null => false, :limit => 128
      t.column :url_slug, :string, :null => false, :limit => 32
      t.column :descr, :string, :null => false
      t.column :long_descr, :string, :null => false
    end
  end

  def self.down
    drop_table :videos
  end
end
