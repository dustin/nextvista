# == Schema Information
# Schema version: 9
#
# Table name: languages
#
#  id   :integer       not null, primary key
#  code :string(2)     not null
#

class Language < ActiveRecord::Base

  validates_uniqueness_of :code, :case_sensitive => false

end
