##### Float Range

```example.rb```:
```ruby
require 'test_values'

values = StringValues.numerics_in_range((4.5..10.5))
p values
```

```output.txt```:
```
{:min_value=>"4.5", :max_value=>"10.5"}
```
