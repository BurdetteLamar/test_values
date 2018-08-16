require 'test_helper'

class NumericValuesTest < Minitest::Test

  TYPE_ERROR_MESSAGE_FORMAT = 'Parameter %s must be instance of %s, not %s'
  INFINITE_ARGUMENT_ERROR_FORMAT = 'Parameter %s must be finite, not Infinity'

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
          :min_value => range.first,
          :max_value => range.last,
      }
      actual_values = NumericValues.numerics_in_range(range)
      assert_equal(expected_values, actual_values)
    end
    {
        ('a'..'z') => format(TYPE_ERROR_MESSAGE_FORMAT, 'range.first', Numeric, '"a"')
    }.each_pair do |range, expected_message|
      e = assert_raises(TypeError) do
        actual_values = NumericValues.numerics_in_range(range)
      end
      assert_equal(expected_message, e.message)
    end
  end

  def test_numerica_not_in_range
    [
        [-1, 1],
        [-1, 1.1],
        [-1.1, 1],
        [-1.1, 1.1],
    ].each do |pair|
      [
          (pair.first..pair.last),
          (pair.last..pair.first),
      ].each do |range|
        actual_values = NumericValues.numerics_not_in_range(range)
        assert_equal([:too_small, :too_large], actual_values.keys)
        assert_operator(actual_values.fetch(:too_small), :<, range.first)
        assert_operator(actual_values.fetch(:too_large), :>, range.last)
        p [range, actual_values]
      end
    end
    {
        ('a'..'z') => format(TYPE_ERROR_MESSAGE_FORMAT, 'range.first', Numeric, '"a"')
    }.each_pair do |range, expected_message|
      e = assert_raises(TypeError) do
        actual_values = NumericValues.numerics_in_range(range)
      end
      assert_equal(expected_message, e.message)
    end
    {
        (Float::INFINITY..0) => format(INFINITE_ARGUMENT_ERROR_FORMAT, 'range.first'),
        (Float::INFINITY..Float::INFINITY) => format(INFINITE_ARGUMENT_ERROR_FORMAT, 'range.first'),
        (0..Float::INFINITY) => format(INFINITE_ARGUMENT_ERROR_FORMAT, 'range.last'),
    }.each_pair do |range, regexp|
      e = assert_raises(ArgumentError) do
        actual_values = NumericValues.numerics_not_in_range(range)
      end
        assert_match(regexp, e.message)
    end
  end

end
