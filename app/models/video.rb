# == Schema Information
# Schema version: 5
#
# Table name: videos
#
#  id           :integer       not null, primary key
#  submitter_id :integer       not null
#  submit_date  :datetime      not null
#  language_id  :integer       not null
#  duration     :integer       not null
#  title        :string(128)   not null
#  slug         :string(32)    not null
#  descr        :string(255)   not null
#  long_descr   :string(255)   not null
#

class Video < ActiveRecord::Base

  acts_as_taggable
  acts_as_slugable :source_column => :title, :target_column => :url_slug

  belongs_to :submitter, :class_name => "User", :foreign_key => "submitter_id"
  belongs_to :language

  validates_presence_of :title, :descr, :long_descr, :duration, :language, :submitter
end
