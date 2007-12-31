# == Schema Information
# Schema version: 10
#
# Table name: languages
#
#  id   :integer       not null, primary key
#  code :string(2)     not null
#

class Language < ActiveRecord::Base

  validates_uniqueness_of :code, :case_sensitive => false

  def to_s
    code
  end

end
