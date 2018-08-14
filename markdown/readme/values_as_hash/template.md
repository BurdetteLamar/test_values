### Values As Hash

Generally speaking, a values method whose name is plural returns a hash.

The calling test can iterate over the hash, using the keys as labels and the values as test data:

@[ruby](code.rb)

@[:code_block]

```ruby
StringValues.strings_in_length_range((4..10)).each pair do |label, string}
  assert_nothing_raised(Exception) do
    test_something_using_string(string)
  end
end
```
