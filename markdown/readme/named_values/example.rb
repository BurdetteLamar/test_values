require 'minitest/autorun'

require 'test_values'

require_relative 'my_items'

class MyTest < Minitest::Test

  def test_bad_item_length
    items = MyItems.new
    values  = StringValues.strings_not_in_length_range((4..8))
    puts "Testing with values #{values.inspect}"
    values.each_pair do |name, value|
      message = "Value #{value.inspect} should raise an exception because it is #{name}."
      puts "\n#{message}"
      e = assert_raises(ArgumentError, message) do
        items.add_item(value)
      end
      puts "Got exception #{e.inspect}"
    end

  end

end
