# Test Values

[![Gem](https://img.shields.io/gem/v/test_values.svg?style=flat)](http://rubygems.org/gems/test_values "View this project in Rubygems")

This project makes it easy to generate _and utilize_ certain kinds of values for testing software.

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
Run options: --seed 15541

# Running:

Testing with values {:too_short=>"xxx", :too_long=>"xxxxxxxxx"}

Value "xxx" should raise an exception because it is too_short.
Got exception #<ArgumentError: xxx>

Value "xxxxxxxxx" should raise an exception because it is too_long.
Got exception #<ArgumentError: xxxxxxxxx>
.

Finished in 0.001459s, 685.4216 runs/s, 1370.8433 assertions/s.

1 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```

## Classes

- [StringValues](#class-stringvalues)
- [NumericValues](#class-numericvalues)

### Class ```StringValues```

#### Methods

- [strings_in_length_range](#method-strings_in_length_range)
- [strings_not_in_length_range](#method-strings_not_in_length_range)
- [string_of_length](#method-string_of_length)

#### Method ```strings_in_length_range```

##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.strings_in_length_range((4..10))
p values
```

```output.txt```:
```
{:min_length=>"xxxx", :max_length=>"xxxxxxxxxx"}
```

##### Base String

```example.rb```:
```ruby
require 'test_values'

values = StringValues.strings_in_length_range((4..10), 'abc')
p values
```

```output.txt```:
```
{:min_length=>"abca", :max_length=>"abcabcabca"}
```

#### Method ```strings_not_in_length_range```

##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.strings_not_in_length_range((4..10))
p values
```

```output.txt```:
```
{:too_short=>"xxx", :too_long=>"xxxxxxxxxxx"}
```

##### Base String

```example.rb```:
```ruby
require 'test_values'

values = StringValues.strings_not_in_length_range((4..10), 'abc')
p values
```

```output.txt```:
```
{:too_short=>"abc", :too_long=>"abcabcabcab"}
```

#### Method ```string_of_length```

##### Simple

```example.rb```:
```ruby
require 'test_values'

s = StringValues.string_of_length(5)
p s
```

```output.txt```:
```
"xxxxx"
```

##### Base String

```example.rb```:
```ruby
require 'test_values'

s = StringValues.string_of_length(5, 'abc')
p s
```

```output.txt```:
```
"abcab"
```


### Class ```NumericValues```

#### Methods

- [numerics_in_range](#method-numerics_in_range)
- [numerics_not_in_range](#method-numerics_not_in_range)

#### Method ```numerics_in_range```

##### Integer Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_in_range((4..10))
p values
```

```output.txt```:
```
{:min_value=>4, :max_value=>10}
```

##### Float Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_in_range((4.5..10.5))
p values
```

```output.txt```:
```
{:min_value=>4.5, :max_value=>10.5}
```

##### Mixed Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_in_range((4..10.5))
p values
```

```output.txt```:
```
{:min_value=>4, :max_value=>10.5}
```
#### Method ```numerics_not_in_range```

##### Integer Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_not_in_range((4..10))
p values
```

```output.txt```:
```
{:too_small=>3, :too_large=>11}
```

##### Float Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_not_in_range((4.5..10.5))
p values
```

```output.txt```:
```
{:too_small=>4.499999999999999, :too_large=>10.500000000000002}
```

##### Mixed Range

```example.rb```:
```ruby
require 'test_values'

values = NumericValues.numerics_not_in_range((4..10.5))
p values
```

```output.txt```:
```
{:too_small=>3, :too_large=>10.500000000000002}
```
