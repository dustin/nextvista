require File.dirname(__FILE__) + '/../test_helper'

class RatingTest < Test::Unit::TestCase
  fixtures :ratings, :videos, :users

  def test_rating
    assert_in_delta 3.5, videos(:one).rating, 2 ** -20
  end

  def test_new_rating
    r=Rating.new :value => 4
    r.user = users(:thirdguy)
    videos(:one).ratings << r
    assert_in_delta (11.0/3.0), videos(:one).reload.rating, 2 ** -20
  end

  def test_change_rating
    videos(:one).rate(users(:quentin), 4)
    assert_in_delta 4, videos(:one).reload.rating, 2 ** -20
  end

end
