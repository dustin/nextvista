require File.dirname(__FILE__) + '/../test_helper'
require 'video_controller'

# Re-raise errors caught by the controller.
class VideoController; def rescue_action(e) raise e end; end

class VideoControllerTest < Test::Unit::TestCase

  fixtures :videos, :users, :tags, :taggings

  def setup
    @controller = VideoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_equal [1, 2], assigns['videos'].map(&:id).sort
  end

  def test_by_slug
    get :show, :slug => 'something-cool'
    assert_equal videos(:one), assigns['video']
  end

  def test_by_slug2
    get :show, :slug => 'something-less-cool'
    assert_equal videos(:two), assigns['video']
  end

end
