## Named Values

Generally speaking, a method in this library whose name is plural returns a hash of named values.

The calling test can iterate over the hash, using the names as labels and the values as test data:

@[ruby](example.rb)

@[:code_block](output.txt)

(If you're nosy, you can peek at class [MyItems](example.rb).)
