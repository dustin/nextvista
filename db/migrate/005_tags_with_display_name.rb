class TagsWithDisplayName < ActiveRecord::Migration
  def self.up
    add_column :tags, :display_name, :string, :limit => 32
  end

  def self.down
    remove_column :tags, :display_name
  end
end
