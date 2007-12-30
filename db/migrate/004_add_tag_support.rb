class AddTagSupport < ActiveRecord::Migration
  def self.up
    #Table for your Tags
    create_table :tags do |t|
      t.column :name, :string, :limit => 32, :null => false
      t.column :display_name, :string, :limit => 64, :null => true
    end

    create_table :taggings do |t|
      t.column :tag_id, :integer, :null => false
      #id of tagged object
      t.column :taggable_id, :integer, :null => false
      #type of object tagged
      t.column :taggable_type, :string, :limit => 32, :null => false
    end

    # Index your tags/taggings
    add_index :tags, :name
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
