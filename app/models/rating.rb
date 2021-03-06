# == Schema Information
# Schema version: 15
#
# Table name: ratings
#
#  id       :integer       not null, primary key
#  user_id  :integer       not null
#  video_id :integer       not null
#  value    :integer       not null
#

class Rating < ActiveRecord::Base

  attr_accessible :video_id, :value

  validates_presence_of :user, :video, :value

  belongs_to :user
  belongs_to :video

end
