require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'
require 'comment'

# Re-raise errors caught by the controller.
class AdminController; def rescue_action(e) raise e end; end

# Add a test method here
class Comment
  def self.visible_count
    count :conditions => {:deleted => false}
  end
end

class AdminControllerTest < Test::Unit::TestCase

  include AuthenticatedTestHelper

  fixtures :all

  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_authentication_required
    get :index
    assert_redirected_to :controller => :sessions, :action => :new
  end

  def test_authorization
    login_as :aaron
    get :index
    assert_redirected_to :controller => :sessions, :action => :new
  end

  # XXX:  The following two tests break in rake, but not in textmate.
  def xxx_test_toggle_comment_delete
    login_as :quentin
    assert_difference Comment, :visible_count, -1 do
      xhr :post, :toggle_comment_delete, :id => 1
      assert_response :success
      assert_template 'toggle_comment_delete'
    end
    assert_equal 1, assigns['comment'].id
  end

  def xxx_test_toggle_comment_delete2
    login_as :quentin
    assert_difference Comment, :visible_count do
      xhr :post, :toggle_comment_delete, :id => 3
      assert_response :success
      assert_template 'toggle_comment_delete'
    end
    assert_equal 3, assigns['comment'].id
  end

  def test_recent_comments
    login_as :quentin
    get :recent_comments
    assert_equal comments(:deleted, :two, :one), assigns(:comments)
  end

  def test_incoming
    login_as :quentin
    get :incoming
    assert_response :success
  end

end
