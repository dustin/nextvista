# == Schema Information
# Schema version: 15
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
#  filename     :string(255)   
#  meta         :text          
#

require 'video_converter'

class IncomingVideo < ActiveRecord::Base

  IncomingVideo::STATE_NEW = 0
  IncomingVideo::STATE_TRANSFERRED = 1
  IncomingVideo::STATE_ENCODED = 2
  IncomingVideo::STATE_COMPLETE = 3
  IncomingVideo::STATE_ERROR = 255

  serialize :meta

  belongs_to :submitter, :class_name => "User", :foreign_key => "submitter_id"
  belongs_to :language

  attr_accessible :title, :descr, :long_descr, :submitter_id, :language_id, :size

  async_after_create do |iv|
    VideoConverter.convert iv
  end

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

  def url
    "http://media.west.spy.net/nextvista/incoming/#{self.id}.bin"
  end

  def public_url
    "http://nvmedia.west.spy.net/flv/#{self.id}/#{self.filename}"
  end

  def width
    if self.meta
      self.meta['specs']['video']['width']
    else
      320
    end
  end

  def height
    if self.meta
      self.meta['specs']['video']['height']
    else
      320
    end
  end


end
