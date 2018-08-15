require 'minitest/autorun'

require 'test_values'

class MyTest < Minitest::Test

  def test_bad_name_length
    names = MyNames.new
    values  = StringValues.strings_not_in_length_range((4..8))
    puts "Values: #{values.inspect}"
    values.each_pair do |label, name|
      message = "Name #{name.inspect} should raise an exception because it is #{label}."
      puts message
      assert_raises(ArgumentError, message) do
        names.add_name(name)
        puts 'OK'
      end
    end

  end

end

class MyNames

  attr_accessor :names

  def initialize
    self.names = []
  end

  def add_name(name)
    raise ArgumentError.new(name) unless (4..8).include?(name.size)
    names.push(name)
  end

end
