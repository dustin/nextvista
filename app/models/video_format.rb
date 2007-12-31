# == Schema Information
# Schema version: 10
#
# Table name: video_formats
#
#  id        :integer       not null, primary key
#  name      :string(64)    not null
#  mime_type :string(32)    not null
#

class VideoFormat < ActiveRecord::Base

  validates_presence_of :name, :mime_type
  validates_uniqueness_of :name, :mime_type

end
