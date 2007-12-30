require File.dirname(__FILE__) + '/../test_helper'

class VideoFormatTest < Test::Unit::TestCase
  fixtures :video_formats

  def test_new_format
    f=VideoFormat.new :name => 'Test Fmt', :mime_type => 'video/test'
    f.save!
    assert_equal t, f.id
  end

  def test_duplicate_format
    f=VideoFormat.new :name => 'Quicktime', :mime_type => 'video/quicktime'
    assert_raises(ActiveRecord::RecordInvalid) do
      f.save!
    end
  end

end
