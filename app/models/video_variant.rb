# == Schema Information
# Schema version: 14
#
# Table name: video_variants
#
#  id        :integer       not null, primary key
#  video_id  :integer       not null
#  format_id :integer       not null
#  width     :integer       not null
#  height    :integer       not null
#  size      :integer       not null
#

class VideoVariant < ActiveRecord::Base

  attr_accessible :video, :format_id, :width, :height, :size

  validates_presence_of :format, :width, :height, :size

  belongs_to :video
  belongs_to :format, :class_name => "VideoFormat", :foreign_key => "format_id"

end
