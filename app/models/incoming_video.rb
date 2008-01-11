# == Schema Information
# Schema version: 13
#
# Table name: incoming_videos
#
#  id           :integer       not null, primary key
#  title        :string(255)   not null
#  descr        :string(255)   not null
#  long_descr   :string(255)   not null
#  submitter_id :integer       not null
#  language_id  :integer       not null
#  size         :integer       not null
#  state        :integer       default(0)
#  remote_id    :integer       
#  created_at   :datetime      
#  updated_at   :datetime      
#

class IncomingVideo < ActiveRecord::Base

  IncomingVideo::STATE_NEW = 0
  IncomingVideo::STATE_TRANSFERRED = 1
  IncomingVideo::STATE_ENCODED = 2

  belongs_to :submitter, :class_name => "User", :foreign_key => "submitter_id"
  belongs_to :language

  attr_accessible :title, :descr, :long_descr, :submitter_id, :language_id, :size

  validates_presence_of :title
  validates_presence_of :descr
  validates_presence_of :long_descr
  validates_presence_of :submitter
  validates_presence_of :language
  validates_presence_of :size
  validates_presence_of :state

  def new
    super
    created_at = Time.now
    state = STATE_NEW
  end

end
