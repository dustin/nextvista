require File.dirname(__FILE__) + '/../test_helper'

require 'video_converter'

class HeywatchControllerTest < ActionController::TestCase

  fixtures :incoming_videos

  def test_encoded
    remid=6926
    iv=incoming_videos(:one)
    iv.remote_id = remid
    iv.save!
    VideoConverter.expects(:fetch).with(iv,
      'Blah.flv', 'http://www.spy.net/blah.bin').once
    post :encoded, :job_id => 2375, :video_id => remid,
      :encoded_video_id => 88452, :filename => 'Blah.flv',
      :link => 'http://www.spy.net/blah.bin'
    assert_response :success
    v=IncomingVideo.find incoming_videos(:one).id
    assert_equal IncomingVideo::STATE_ENCODED, v.state
  end

  def test_errored
    post :errored, :nvid => incoming_videos(:one).id, :error_code => 104
    assert_response :success
    assert_equal HeyWatch::ErrorCode[104], assigns['error_msg']
  end

  def test_errored_with_discover_id
    post :errored, :nvid => incoming_videos(:one).id, :discover_id => 9185
    assert_response :success
    assert_equal "No video link found", assigns['error_msg']
  end

end
