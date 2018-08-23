##### Simple

```example.rb```:
```ruby
require 'test_values'

values = StringValues.not_ip_addresses
p values
```

```output.txt```:
```
{:nil=>nil, :not_string=>0, :empty=>"", :invalid_digits=>"xxx.xxx.xxx.xxx"}
```
