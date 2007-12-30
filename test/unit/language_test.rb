require File.dirname(__FILE__) + '/../test_helper'

class LanguageTest < Test::Unit::TestCase
  fixtures :languages

  def test_creation
    l=Language.new :code => "es"
    l.save!
    assert_equal l, Language.find_by_code("es")
  end

  def test_duplicate_save
    l=Language.new :code => "en"
    assert_raises(ActiveRecord::RecordInvalid) do
      l.save!
    end
  end
end
