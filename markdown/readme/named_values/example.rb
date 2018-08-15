require 'minitest/autorun'

require 'test_values'

class MyTest < Minitest::Test

  def test_bad_item_length
    items = MyItems.new
    values  = StringValues.strings_not_in_length_range((4..8))
    puts "Values: #{values.inspect}"
    values.each_pair do |name, value|
      message = "Value #{value.inspect} should raise an exception because it is #{name}."
      puts message
      assert_raises(ArgumentError, message) do
        items.add_item(value)
        puts 'OK'
      end
    end

  end

end

class MyItems

  attr_accessor :items

  def initialize
    self.items = []
  end

  def add_name(item)
    raise ArgumentError.new(item) unless (4..8).include?(item.size)
    items.push(item)
  end

end
