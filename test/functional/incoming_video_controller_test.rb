require File.dirname(__FILE__) + '/../test_helper'

class IncomingVideoControllerTest < ActionController::TestCase

  include AuthenticatedTestHelper

  fixtures :all

  def teardown
    if defined? @filename
      File.unlink @filename
    end
    super
  end

  def test_upload_form_not_logged_in
    get :new
    assert_redirected_to login_url
  end

  def test_upload_form
    login_as :quentin
    assert_no_difference IncomingVideo, 'count' do
      get :new
      assert_response :success
    end
  end

  def test_upload
    login_as :quentin
    assert_difference IncomingVideo, 'count' do
      HeyWatch::Discover.expects(:create).once
      post :new, :incoming_video => {
          :title => 'a title', :descr => 'a description',
          :long_descr => 'a long description', :language_id => languages(:en).id},
        :video_file => fixture_file_upload("incoming_videos.yml")
      assert_redirected_to :action => :uploaded
      @filename = assigns['filename']
    end
  end

  def test_uploaded
    login_as :quentin
    get :uploaded
    assert_response :success
  end

  # Sure would like to make this work.
  def broken_test_failed_upload
    login_as :quentin
    exceptions = 0
    assert_no_difference IncomingVideo, 'count' do
      HeyWatch::Discover.expects(:create).once
      mockfile = Object.new
      mockfile.expects(:length).once.returns 91848
      mockfile.expects(:read).once.raises "Hell"
      begin
        post :new, :incoming_video => {
            :title => 'a title', :descr => 'a description',
            :long_descr => 'a long description', :language_id => languages(:en)},
          :video_file => mockfile
      rescue
        exceptions += 1
      ensure
        @filename = assigns['filename']
      end
    end
    assert_equal 1, exceptions
  end

end
