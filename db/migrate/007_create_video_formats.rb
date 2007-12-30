class CreateVideoFormats < ActiveRecord::Migration
  # name = models.CharField(maxlength=64)
  # mime_type = models.CharField(maxlength=32)
  
  def self.up
    create_table :video_formats do |t|
      t.column :name, :string, :limit => 64, :null => false
      t.column :mime_type, :string, :limit => 32, :null => false
    end
  end

  def self.down
    drop_table :video_formats
  end
end
