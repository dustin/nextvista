# == Schema Information
# Schema version: 12
#
# Table name: comments
#
#  id         :integer       not null, primary key
#  user_id    :integer       not null
#  video_id   :integer       not null
#  created_at :datetime      not null
#  comment    :text          not null
#  public     :boolean       default(TRUE)
#  deleted    :boolean       
#  ip_address :string(255)   not null
#

class Comment < ActiveRecord::Base

  validates_presence_of :user, :video, :comment, :ip_address

  belongs_to :user
  belongs_to :video

end
