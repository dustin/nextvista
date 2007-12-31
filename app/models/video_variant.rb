# == Schema Information
# Schema version: 12
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

  validates_presence_of :video, :format, :width, :height, :size

  belongs_to :video
  belongs_to :format

end
