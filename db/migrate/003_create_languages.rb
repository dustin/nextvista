class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.column :code, :string, :limit => 2, :null => false
    end
  end

  def self.down
    drop_table :languages
  end
end
