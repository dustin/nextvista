# == Schema Information
# Schema version: 9
#
# Table name: ratings
#
#  id       :integer       not null, primary key
#  user_id  :integer       not null
#  video_id :integer       not null
#  value    :integer       not null
#

class Rating < ActiveRecord::Base

  validates_presence_of :user, :video, :value

  belongs_to :user
  belongs_to :video

end
