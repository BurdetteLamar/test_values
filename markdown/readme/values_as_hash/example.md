### Values As Hash

Generally speaking, a values method whose name is plural returns a hash.

The calling test can iterate over the hash, using the keys as labels and the values as test data:

```example.rb```:
```ruby
require 'minitest/autorun'

require 'test_values'

class MyTest < Minitest::Test

  def test_bad_name_length
    names = MyNames.new
    values  = StringValues.strings_not_in_length_range((4..8))
    puts "Values: #{values.inspect}"
    values.each_pair do |label, name|
      message = "Name #{name.inspect} should raise an exception because it is #{label}."
      puts message
      assert_raises(ArgumentError, message) do
        names.add_name(name)
        puts 'OK'
      end
    end

  end

end

class MyNames

  attr_accessor :names

  def initialize
    self.names = []
  end

  def add_name(name)
    raise ArgumentError.new(name) unless (4..8).include?(name.size)
    names.push(name)
  end

end
```

```output.txt```:
```
Run options: --seed 20663

# Running:

Values: {:too_short=>"xxx", :too_long=>"xxxxxxxxx"}
Name "xxx" should raise an exception because it is too_short.
Name "xxxxxxxxx" should raise an exception because it is too_long.
.

Finished in 0.001403s, 712.8071 runs/s, 1425.6143 assertions/s.

1 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```
