require File.dirname(__FILE__) + '/../test_helper'
require 'comment_controller'

# Re-raise errors caught by the controller.
class CommentController; def rescue_action(e) raise e end; end

class CommentControllerTest < Test::Unit::TestCase

  include AuthenticatedTestHelper

  fixtures :users, :videos, :comments

  def setup
    @controller = CommentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_new_comment_without_login
    post :create, :comment => {:video_id => videos(:one).id, :comment => "Hi"}
    assert_response :redirect
    assert_redirected_to :controller => :sessions, :action => 'new'
  end

  def test_new_comment
    login_as :quentin
    assert_difference Comment, :count do
      post :create, :comment => {:video_id => videos(:one).id, :comment => "Hi"}
    end
  end

  def test_new_comment_fake_user
    login_as :quentin
    assert_difference Comment, :count do
      post :create, :comment => {:video_id => videos(:one).id, :comment => "Hi", :user_id => 2}
    end
    assert_equal 1, assigns['comment'].user_id
  end

  def test_new_comment_fake_ip
    login_as :quentin
    assert_difference Comment, :count do
      post :create, :comment => {:video_id => videos(:one).id, :comment => "Hi", :ip_address => "1.2.3.4"}
    end
    assert_equal "0.0.0.0", assigns['comment'].ip_address
  end

end
