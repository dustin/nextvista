class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.column :user_id, :integer, :null => false
      t.column :video_id, :integer, :null => false
      t.column :value, :integer, :null => false
    end

    add_index :ratings, [:user_id, :video_id], :name => "idx_rating", :unique => true
  end

  def self.down
    drop_table :ratings
    remove_index :ratings, :name => :idx_rating
  end
end
