require File.dirname(__FILE__) + '/../test_helper'

class VideoVariantTest < Test::Unit::TestCase
  fixtures :video_variants, :video_formats, :videos

  def test_find_variants
    assert_equal [1, 2], videos(:one).video_variants.map(&:id).sort
  end

end
