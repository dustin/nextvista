# == Schema Information
# Schema version: 9
#
# Table name: videos
#
#  id           :integer       not null, primary key
#  submitter_id :integer       not null
#  submit_date  :datetime      not null
#  language_id  :integer       not null
#  duration     :integer       not null
#  title        :string(128)   not null
#  url_slug     :string(32)    not null
#  descr        :string(255)   not null
#  long_descr   :string(255)   not null
#

class Video < ActiveRecord::Base

  acts_as_taggable
  acts_as_slugable :source_column => :title, :target_column => :url_slug

  belongs_to :submitter, :class_name => "User", :foreign_key => "submitter_id"
  belongs_to :language

  has_many :video_variants
  has_many :ratings

  validates_presence_of :title, :descr, :long_descr, :duration, :language, :submitter

  # Rate this video.
  def rate(user, rating)
    r=Rating.find_or_create_by_user_id_and_video_id(user, self)
    r.value = rating
    r.save!
  end

  def rating
    ratings.average(:value, :conditions => {:video_id => self})
  end

end
