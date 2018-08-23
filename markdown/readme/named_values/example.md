## Named Values

Generally speaking, a method in this library whose name is plural returns a hash of named values.

The calling test can iterate over the hash, using the names as labels and the values as test data:

```example.rb```:
```ruby
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
```

```output.txt```:
```
Run options: --seed 9626

# Running:

Testing with values {:too_short=>"xxx", :too_long=>"xxxxxxxxx"}

Value "xxx" should raise an exception because it is too_short.
Got exception #<ArgumentError: xxx>

Value "xxxxxxxxx" should raise an exception because it is too_long.
Got exception #<ArgumentError: xxxxxxxxx>
.

Finished in 0.001457s, 686.1600 runs/s, 1372.3200 assertions/s.

1 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

(If you're nosy, you can peek at class [MyItems](https://raw.githubusercontent.com/BurdetteLamar/test_values/master/markdown/readme/named_values/my_items.rb).)
