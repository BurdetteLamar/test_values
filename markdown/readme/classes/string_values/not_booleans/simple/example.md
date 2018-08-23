##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.not_booleans
p values
```

```output.txt```:
```
{:nil=>nil, :not_string=>0, :empty=>"", :invalid_word=>"not_boolean"}
```
