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

  def test_numerics_in_range
    [
        (-1..1),
        (-1.1..1.1),
        (-1..1.1),
        (-1.1..1),
        (0..Float::INFINITY),
        (Float::INFINITY..Float::INFINITY),
    ].each do |range|
      expected_values = {
          :min_value => range.first.to_s,
          :max_value => range.last.to_s,
      }
      actual_values = StringValues.numerics_in_range(range)
      assert_equal(expected_values, actual_values)
    end
    {
        ('a'..'z') => format(NumericValuesTest::TYPE_ERROR_MESSAGE_FORMAT, 'range.first', Numeric, '"a"')
    }.each_pair do |range, expected_message|
      e = assert_raises(TypeError) do
        StringValues.numerics_in_range(range)
      end
      assert_equal(expected_message, e.message)
    end
    assert_raises(ArgumentError) do
      StringValues.numerics_in_range((1..0))
    end
  end

  def to_numeric(value)
    value_i = value.to_i
    return value_i if value_i.to_s == value
    value.to_f
  end

  def test_numerica_not_in_range
    [
        (-1..1),
        (-1..1.1),
        (-1.1..1),
        (-1.1..1.1),
    ].each do |range|
      actual_values = StringValues.numerics_not_in_range(range)
      assert_equal([:too_small, :too_large], actual_values.keys)
      too_small_string = actual_values.fetch(:too_small)
      too_small_numeric = to_numeric(too_small_string)
      assert_operator(too_small_numeric, :<, range.first)
      too_large_string = actual_values.fetch(:too_large)
      too_large_numeric = to_numeric(too_large_string)
      assert_operator(too_large_numeric, :>, range.last)
    end
    {
        ('a'..'z') => format(NumericValuesTest::TYPE_ERROR_MESSAGE_FORMAT, 'range.first', Numeric, '"a"')
    }.each_pair do |range, expected_message|
      e = assert_raises(TypeError) do
        StringValues.numerics_in_range(range)
      end
      assert_equal(expected_message, e.message)
    end
    {
        (Float::INFINITY..Float::INFINITY) => format(NumericValuesTest::INFINITE_ARGUMENT_ERROR_FORMAT, 'range.first'),
        (0..Float::INFINITY) => format(NumericValuesTest::INFINITE_ARGUMENT_ERROR_FORMAT, 'range.last'),
    }.each_pair do |range, regexp|
      e = assert_raises(ArgumentError) do
        StringValues.numerics_not_in_range(range)
      end
      assert_match(regexp, e.message)
    end
    assert_raises(ArgumentError) do
      StringValues.numerics_not_in_range((1..0))
    end
  end

  def test_misspelled
    {
        :a => 'b',
        :z => 'a',
        :A => 'B',
        :Z => 'A',
        :'0' => '1',
        :'9' => '0',
        :_ => 'A',
        :'#a' => '#b',
        :'!z' => '!a',
        :'.A' => '.B',
        :'?Z' => '?A',
        :',0' => ',1',
        :';9' => ';0',
        :'+_' => '+A',
        :'a#' => 'b#',
        :'z!' => 'a!',
        :'A.' => 'B.',
        :'Z?' => 'A?',
        :'0,' => '1,',
        :'9;' => '0;',
        :'_+' => 'A+',
    }.each_pair do |symbol, expected|
      string = symbol.to_s
      actual = StringValues.misspelled(string)
      assert_equal(expected, actual)
    end
    {
        '' => ArgumentError,
        ' ' => ArgumentError,
        true => TypeError,
    }.each do |obj, klass|
      assert_raises(klass) do
        StringValues.misspelled(obj)
      end
    end
  end

  def test_booleans
    expected = {:true => 'true', :false => 'false'}
    actual = StringValues.booleans
    assert_equal(expected, actual)
  end

  def not_strings
    {:nil => nil, :not_string => 0}
  end

  def not_nonempties
    not_strings.merge(:empty => '')
  end

  def test_not_nonempties
    expected = not_nonempties
    actual = StringValues.not_nonempties
    assert_equal(expected, actual)
  end

  def test_not_strings
    expected = not_strings
    actual = StringValues.not_strings
    assert_equal(expected, actual)
  end

  def test_not_uuids
    expected = not_nonempties.merge(:invalid_digits => 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')
    actual = StringValues.not_uuids
    assert_equal(expected, actual)
  end

  def test_not_booleans
    expected = not_nonempties.merge(:invalid_word => 'not_boolean')
    actual = StringValues.not_booleans
    assert_equal(expected, actual)
  end

  def test_not_ip_addresses
    expected = not_nonempties.merge(:invalid_digits => 'xxx.xxx.xxx.xxx')
    actual = StringValues.not_ip_addresses
    assert_equal(expected, actual)
  end

  def not_nonnegative_integers
    not_nonempties.merge(:negative => '-1')
  end
  def test_not_nonnegative_integers
    expected = not_nonnegative_integers
    actual = StringValues.not_nonnegative_integers
    assert_equal(expected, actual)
  end

  def test_not_positive_integers
    expected = not_nonnegative_integers.merge(:zero => '0')
    actual = StringValues.not_positive_integers
    assert_equal(expected, actual)
  end

end
