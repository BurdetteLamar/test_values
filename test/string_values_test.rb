require 'test_helper'

class StringValuesTest < Minitest::Test

  def test_string_of_length
    [0, 1, 3, 7].each do |length|
      expected = 'x' * length
      actual = StringValues.string_of_length(length)
      assert_equal(expected, actual, "length=#{length}")
    end
    base_string = 'abc'
    {
        0 =>  '',
        1 =>  'a',
        3 =>  'abc',
        7 =>  'abcabca',
    }.each_pair do |length, expected|
      actual = StringValues.string_of_length(length, base_string)
      assert_equal(expected, actual, "length=#{length} base_string=#{base_string}")
    end
    {
        ['a', 'x'] => /length/,
        [1, 1] => /base_string/,
    }.each_pair do |args, regexp|
      e = assert_raises(TypeError) do
        StringValues.string_of_length(*args)
      end
      assert_match(regexp, e.message)
    end
    {
        [-1, 'x'] => /length/,
    }.each_pair do |args, regexp|
      e = assert_raises(RangeError) do
        StringValues.string_of_length(*args)
      end
      assert_match(regexp, e.message)
    end
  end

  def test_strings_in_length_range
    base_string = 'x'
    expected = {}
    [
        (0..15),
        (1..1),
    ].each do |range|
      expected.store(:min_length, base_string * range.first)
      expected.store(:max_length, base_string * range.last)
      actual = StringValues.strings_in_length_range(range)
      assert_equal(expected, actual, "range=#{range}")
    end
    {
        ['x', 'x'] => /range/,
        [(0..4), 1] => /base_string/,
    }.each_pair do |args, regexp|
      e = assert_raises(TypeError) do
        StringValues.strings_in_length_range(*args)
      end
      assert_match(regexp, e.message)
    end
    {
        (-1..10) => /length/,
    }.each_pair do |range, regexp|
      e = assert_raises(RangeError) do
        StringValues.strings_in_length_range(range)
      end
      assert_match(regexp, e.message)
    end
  end

  def test_strings_not_in_length_range
    base_string = 'x'
    expected = {}
    [
        (1..15),
        (4..7),
    ].each do |range|
      expected.store(:too_short, base_string * range.first.pred)
      expected.store(:too_long, base_string * range.last.succ)
      actual = StringValues.strings_not_in_length_range(range)
      assert_equal(expected, actual, "range=#{range}")
    end
    {
        ['x', 'x'] => /range/,
        [(0..4), 1] => /base_string/,
    }.each_pair do |args, regexp|
      e = assert_raises(TypeError) do
        StringValues.strings_not_in_length_range(*args)
      end
      assert_match(regexp, e.message)
    end
    {
        (-1..10) => /length/,
    }.each_pair do |range, regexp|
      e = assert_raises(RangeError) do
        StringValues.strings_not_in_length_range(range)
      end
      assert_match(regexp, e.message)
    end
  end

end
