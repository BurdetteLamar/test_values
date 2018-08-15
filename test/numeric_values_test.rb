require 'test_helper'

class NumericValuesTest < Minitest::Test

  def test_numerics_in_range
    [
        (-1..1),
        (-1.1..1.1),
        (-1..1.1),
        (-1.1..1),
    ].each do |range|
      expected_values = {
          :min_value => range.first,
          :max_value => range.last,
      }
      actual_values = NumericValues.numerics_in_range(range)
      assert_equal(expected_values, actual_values)
    end
  end

  def test_numerica_not_in_range
    [
        (-1..1),
        (-1..1.1),
        (-1.1..1),
        (-1.1..1.1),
    ].each do |range|
      actual_values = NumericValues.numerics_not_in_range(range)
      assert_equal([:too_small, :too_large], actual_values.keys)
      assert_operator(actual_values.fetch(:too_small), :<, range.first)
      assert_operator(actual_values.fetch(:too_large), :>, range.last)
    end
  end

end
