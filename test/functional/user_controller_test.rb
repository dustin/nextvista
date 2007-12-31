require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'

# Re-raise errors caught by the controller.
class UserController; def rescue_action(e) raise e end; end

class UserControllerTest < Test::Unit::TestCase

  fixtures :users, :videos

  def setup
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_show_quentin
    get :show, :login => 'quentin'
    assert_equal users(:quentin), assigns['user']
    assert_equal [videos(:one), videos(:two)], assigns['videos']
  end

  def test_show_aaron
    get :show, :login => 'aaron'
    assert_equal users(:aaron), assigns['user']
    assert_equal [], assigns['videos']
  end

end
