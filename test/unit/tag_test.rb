require File.dirname(__FILE__) + '/../test_helper'

class TagTest < Test::Unit::TestCase
  fixtures :tags

  def test_display_name
    assert_equal 'tag1', tags(:one).to_s
  end

  def test_display_name_nil
    assert_equal 'Tag Two', tags(:two).to_s
  end

end
