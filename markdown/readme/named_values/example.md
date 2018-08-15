## Named Values

Generally speaking, a values method whose name is plural returns a hash of named values.

The calling test can iterate over the hash, using the names as labels and the values as test data:

```example.rb```:
```ruby
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
```

```output.txt```:
```
Run options: --seed 54795

# Running:

Values: {:too_short=>"xxx", :too_long=>"xxxxxxxxx"}
Value "xxx" should raise an exception because it is too_short.
F

Finished in 0.001641s, 609.4101 runs/s, 609.4101 assertions/s.

  1) Failure:
MyTest#test_bad_item_length [example.rb:14]:
Value "xxx" should raise an exception because it is too_short..
[ArgumentError] exception expected, not
Class: <NoMethodError>
Message: <"undefined method `add_item' for #<MyItems:0x00000002b987f8 @items=[]>">
---Backtrace---
example.rb:15:in `block (2 levels) in test_bad_item_length'
---------------

1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```
