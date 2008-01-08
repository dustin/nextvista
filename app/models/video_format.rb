# == Schema Information
# Schema version: 12
#
# Table name: video_formats
#
#  id        :integer       not null, primary key
#  name      :string(64)    not null
#  mime_type :string(32)    not null
#

class VideoFormat < ActiveRecord::Base

  attr_accessible :name, :mime_type

  validates_presence_of :name, :mime_type
  validates_uniqueness_of :name, :mime_type

end
