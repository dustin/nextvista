require File.dirname(__FILE__) + '/../test_helper'

class HeywatchControllerTest < ActionController::TestCase

  fixtures :incoming_videos

  def test_encoded
    post :encoded, :nvid => incoming_videos(:one).id, :encoded_video_id => 88452
    assert_response :success
    v=IncomingVideo.find incoming_videos(:one).id
    assert_equal 88452, v.remote_id
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
