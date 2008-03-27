require File.dirname(__FILE__) + '/../test_helper'

class VideoVariantTest < Test::Unit::TestCase
  fixtures :all

  def test_find_variants
    assert_equal video_variants(:one, :two).map(&:id).sort,
      videos(:one).video_variants.map(&:id).sort
  end

end
