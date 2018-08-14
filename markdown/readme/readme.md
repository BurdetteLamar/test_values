# Test Values

## Class ```StringValues```

### Method ```string_of_size```

#### Simple

```code.rb```:
```ruby
require 'test_values'

s = StringValues.string_of_size(5)
p s
```

```output.txt```:
```
"xxxxx"
```

#### Base String

```code.rb```:
```ruby
require 'test_values'

s = StringValues.string_of_size(5, 'abc')
p s
```

```output.txt```:
```
"abcab"
```

### Method ```strings_in_length_range```

#### Simple

```code.rb```:
```ruby
require 'test_values'

values = StringValues.strings_in_length_range((4..10))
p values
```

```output.txt```:
```
{:min_length=>"xxxx", :max_length=>"xxxxxxxxxx"}
```

#### Base String

```code.rb```:
```ruby
require 'test_values'

values = StringValues.strings_in_length_range((4..10), 'abc')
p values
```

```output.txt```:
```
{:min_length=>"abca", :max_length=>"abcabcabca"}
```

### Method ```strings_not_in_length_range```

#### Simple

```code.rb```:
```ruby
require 'test_values'

values = StringValues.strings_not_in_length_range((4..10))
p values
```

```output.txt```:
```
{:too_short=>"xxx", :too_long=>"xxxxxxxxxxx"}
```

#### Base String

```code.rb```:
```ruby
require 'test_values'

values = StringValues.strings_not_in_length_range((4..10), 'abc')
p values
```

```output.txt```:
```
{:too_short=>"abc", :too_long=>"abcabcabcab"}
```
