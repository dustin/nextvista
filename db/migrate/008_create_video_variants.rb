class CreateVideoVariants < ActiveRecord::Migration
  def self.up
    create_table :video_variants do |t|
      t.column :video_id, :integer, :null => false
      t.column :format_id, :integer, :null => false
      t.column :width, :integer, :null => false
      t.column :height, :integer, :null => false
      t.column :size, :integer, :null => false
    end
  end

  def self.down
    drop_table :video_variants
  end
end
