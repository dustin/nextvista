require File.dirname(__FILE__) + '/../test_helper'

class VideoTest < Test::Unit::TestCase
  include AuthenticatedTestHelper

  fixtures :videos, :tags, :languages, :users

  def test_video_sluggery
    v=Video.new :submitter => users(:quentin), :submit_date => Time.now,
      :language => languages(:en), :duration => 152, :title => "This Is My Title",
      :descr => "Here's a description.", :long_descr => "Here's a long description."
    v.save!
    assert_equal "this-is-my-title", v.url_slug
  end

  def test_slug_collision
    v=Video.new :submitter => users(:quentin), :submit_date => Time.now,
      :language => languages(:en), :duration => 152, :title => "Something Cool",
      :descr => "Here's a description.", :long_descr => "Here's a long description."
    v.save!
    assert_equal "something-cool-0", v.url_slug
  end

  def test_tags
    v=Video.new :submitter => users(:quentin), :submit_date => Time.now,
      :language => languages(:en), :duration => 152, :title => "This Is My Title",
      :descr => "Here's a description.", :long_descr => "Here's a long description."
    assert_difference Tag, :count do
      v.tag_list = 'tag1 tag2 tag3'
      v.save!
    end
    assert_equal %w(tag1 tag2 tag3), v.tag_list.sort
  end

end
