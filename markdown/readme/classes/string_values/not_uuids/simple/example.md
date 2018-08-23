##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.not_uuids
p values
```

```output.txt```:
```
{:nil=>nil, :not_string=>0, :empty=>"", :invalid_digits=>"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"}
```
