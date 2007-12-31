class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :user_id, :integer, :null => false
      t.column :video_id, :integer, :null => false
      t.column :created_at, :datetime, :null => false
      t.column :comment, :text, :null => false
      t.column :public, :boolean, :default => true
      t.column :deleted, :boolean, :default => false
      t.column :ip_address, :string, :null => false
    end
  end

  def self.down
    drop_table :comments
  end
end
