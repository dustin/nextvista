# == Schema Information
# Schema version: 15
#
# Table name: roles
#
#  id   :integer       not null, primary key
#  name :string(255)   not null
#

class Role < ActiveRecord::Base

  attr_accessible :name

  validates_uniqueness_of :name

  has_and_belongs_to_many :users, :class_name => "User",
    :join_table => "user_roles_map"

  def to_s
    name
  end

end
