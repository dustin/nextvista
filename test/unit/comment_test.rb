require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < Test::Unit::TestCase
  fixtures :comments, :videos, :users

  def test_comments_for_video
    assert_equal 2, videos(:one).comments.size
  end

  def test_comments_for_video2
    assert_equal [], videos(:two).comments
  end

  def test_comment_creation
    c=Comment.new :user => users(:quentin), :video => videos(:one),
      :created_at => Time.now, :comment => "Yeah, it's awesome because I made it.",
      :ip_address => '127.0.0.1'
    c.save!
    assert_equal 3, Video.find(1).comments.length
  end

  def test_comment_logical_delete
    c=Comment.find 1
    c.deleted=true
    c.save!
    assert_equal 1, Video.find(1).comments.size
  end

  def test_comments_from_user_aaron
    assert_equal 1, users(:aaron).comments.length
  end

  def test_comments_from_user_quentin
    assert_equal [], users(:quentin).comments
  end

end
