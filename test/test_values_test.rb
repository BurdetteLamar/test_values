require 'test_helper'

class TestValuesTest < Minitest::Test
  def test_version_number
    refute_nil ::TestValues::VERSION
  end

end
