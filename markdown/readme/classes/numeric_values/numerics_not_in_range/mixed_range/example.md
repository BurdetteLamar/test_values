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
