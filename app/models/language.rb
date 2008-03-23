# == Schema Information
# Schema version: 15
#
# Table name: languages
#
#  id   :integer       not null, primary key
#  code :string(2)     not null
#

class Language < ActiveRecord::Base

  attr_accessible :code

  validates_uniqueness_of :code, :case_sensitive => false

  def to_s
    code
  end

end
