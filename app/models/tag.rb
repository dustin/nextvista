# == Schema Information
# Schema version: 4
#
# Table name: tags
#
#  id           :integer       not null, primary key
#  name         :string(32)    not null
#  display_name :string(64)    
#

class Tag < ActiveRecord::Base

  validates_uniqueness_of :name, :case_sensitive => false

  def to_s
    if display_name.nil?
      name
    else
      display_name
    end
  end

end
