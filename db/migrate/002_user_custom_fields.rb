class UserCustomFields < ActiveRecord::Migration
  
  def self.up
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :is_teacher, :boolean
    add_column :users, :descr, :string
    add_column :users, :referral, :string
  end

  def self.down
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :country
    remove_column :is_teacher, :boolean
    remove_column :descr, :descr
    remove_column :users, :referral
  end
end
