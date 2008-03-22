require File.dirname(__FILE__) + '/../test_helper'

class IncomingVideoTest < ActiveSupport::TestCase

  fixtures :incoming_videos, :users, :languages

  def test_search_by_state_new
    assert_equal [incoming_videos(:one)], IncomingVideo.find_all_by_state(IncomingVideo::STATE_NEW)
  end

  def test_search_by_state_transferred
    assert_equal [incoming_videos(:two)], IncomingVideo.find_all_by_state(IncomingVideo::STATE_TRANSFERRED)
  end

  def test_search_by_state_encoded
    assert_equal [incoming_videos(:three)], IncomingVideo.find_all_by_state(IncomingVideo::STATE_ENCODED)    
  end

  def test_create
    HeyWatch::Discover.expects(:create).once
    iv=IncomingVideo.new :title => 'a title', :descr => 'a descr', :long_descr => 'a long descr',
      :submitter_id => users(:quentin).id, :language_id => languages(:en).id, :size => 82852
    iv.save!
    v=IncomingVideo.find iv.id
    assert_equal 'a title', v.title
    assert_equal 'a descr', v.descr
    assert_equal 'a long descr', v.long_descr
    assert_equal users(:quentin), v.submitter
    assert_equal languages(:en), v.language
    assert_equal 82852, v.size
    assert_not_nil v.created_at
  end

end
