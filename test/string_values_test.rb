require 'test_helper'

class StringValuesTest < Minitest::Test

  def test_string_of_length
    [0, 1, 3, 7].each do |size|
      expected = 'x' * size
      actual = StringValues.string_of_size(size)
      assert_equal(expected, actual, "size=#{size}")
    end
    base_string = 'abc'
    {
        0 =>  '',
        1 =>  'a',
        3 =>  'abc',
        7 =>  'abcabca',
    }.each_pair do |size, expected|
      actual = StringValues.string_of_size(size, base_string)
      assert_equal(expected, actual, "size=#{size} base_string=#{base_string}")
    end
    [
        ['a', 'x'],
        [1, 1],
    ].each do |args|
      e = assert_raises(TypeError) do
        StringValues.string_of_size(*args)
      end
    end
    [
        [-1, 'x'],
    ].each do |args|
      e = assert_raises(RangeError) do
        StringValues.string_of_size(*args)
      end
    end
  end

end
