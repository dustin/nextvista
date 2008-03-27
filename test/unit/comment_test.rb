require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :all

  def test_comments_for_video
    assert_equal 2, videos(:one).comments.size
  end

  def test_comments_for_video2
    assert_equal [], videos(:two).comments
  end

  def test_comment_creation
    c=Comment.new :created_at => Time.now, :comment => "Yeah, it's awesome because I made it."
    c.user = users(:quentin)
    c.ip_address = '127.0.0.1'
    c.video = videos(:one)
    c.save!
    assert_equal 3, videos(:one).reload.comments.length
  end

  def test_comment_logical_delete
    c=comments(:one)
    c.deleted=true
    c.save!
    assert_equal 1, videos(:one).comments.size
  end

  def test_comments_from_user_aaron
    assert_equal 1, users(:aaron).comments.length
  end

  def test_comments_from_user_quentin
    assert_equal [], users(:quentin).comments
  end

end
