##### Integer Range

```example.rb```:
```ruby
require 'test_values'

values = StringValues.numerics_not_in_range((4..10))
p values
```

```output.txt```:
```
{:too_small=>"3", :too_large=>"11"}
```
