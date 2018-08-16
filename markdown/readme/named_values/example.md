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

class MyItems

  attr_accessor :items

  def initialize
    self.items = []
  end

  def add_item(item)
    raise ArgumentError.new(item) unless (4..8).include?(item.length)
    items.push(item)
  end

end
```

```output.txt```:
```
Run options: --seed 37303

# Running:

Testing with values {:too_short=>"xxx", :too_long=>"xxxxxxxxx"}

Value "xxx" should raise an exception because it is too_short.
Got exception #<ArgumentError: xxx>

Value "xxxxxxxxx" should raise an exception because it is too_long.
Got exception #<ArgumentError: xxxxxxxxx>
.

Finished in 0.001486s, 672.8597 runs/s, 1345.7193 assertions/s.

1 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```
