##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.not_positive_integers
p values
```

```output.txt```:
```
{:nil=>nil, :not_string=>0, :empty=>"", :negative=>"-1", :zero=>"0"}
```
