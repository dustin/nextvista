require File.dirname(__FILE__) + '/../test_helper'
require 'tag_controller'

# Re-raise errors caught by the controller.
class TagController; def rescue_action(e) raise e end; end

class TagControllerTest < Test::Unit::TestCase

  fixtures :tags, :videos, :taggings

  def setup
    @controller = TagController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert assigns['tags']
  end

  def test_show_tag1
    get :show, :name => 'tag1'
    assert_equal %w(tag1), assigns['tagnames'].sort
    assert_equal [tags(:one)], assigns['tags']
    assert_equal [tags(:two)], assigns['related']
    assert_equal [videos(:one), videos(:two)], assigns['videos']
  end

  def test_show_tag1_and_tag2
    get :show, :name => 'tag1 tag2'
    assert_equal %w(tag1 tag2), assigns['tagnames'].sort
    assert_equal [tags(:one), tags(:two)], assigns['tags']
    assert_equal [], assigns['related']
    assert_equal [videos(:one)], assigns['videos']
  end

end
