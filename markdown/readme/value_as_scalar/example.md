### Value As Scalar

Generally speaking, a values method whose name is singular returns a scalar, usually a number or string.

```example.rb```:
```ruby
require 'test_values'

my_string = StringValues.string_of_size(5)
p my_string
```

```output.txt```:
```
"xxxxx"
```
