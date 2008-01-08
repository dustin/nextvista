require File.dirname(__FILE__) + '/../test_helper'

class RatingTest < Test::Unit::TestCase
  fixtures :ratings, :videos, :users

  def test_rating
    assert_in_delta 3.5, videos(:one).rating, 2 ** -20
  end

  def test_new_rating
    r=Rating.new :value => 4
    r.user = users(:thirdguy)
    Video.find(1).ratings << r
    assert_in_delta (11.0/3.0), Video.find(1).rating, 2 ** -20
  end

  def test_change_rating
    Video.find(1).rate(users(:quentin), 4)
    assert_in_delta 4, Video.find(1).rating, 2 ** -20
  end

end
