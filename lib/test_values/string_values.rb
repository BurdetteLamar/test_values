class StringValues < ValuesBase

  BASE_STRING = 'x'
  # Return a string of the given +length+,
  # built by trimming or extending the given +base_string+.
  # @param length [Integer] the length of the string to be returned.
  # @param base_string [String] the base string to be trimmed or extended.
  # @return [String] a string of the given length.
  # @raise [TypeError] if +length+ is not an +Integer+.
  # @raise [TypeError] if +base_string+ is not a +String+.
  # @raise [RangeError] if +length+ is negative.
  def self.string_of_length(length, base_string=BASE_STRING)
    self.verify_kind_of('length', Integer, length)
    self.verify_kind_of('base_string', String, base_string)
    self.verify_integer_in_range('length', (0..Float::INFINITY), length)
    return '' if length == 0
    s = base_string
    while s.length < length
      s = s * 2
    end
    return s[0..length-1]
  end

  # Return a hash of strings of minimum and maximum length
  # for the given +range+.
  # @param range [Range] specifies the minimum and maximum string lengths.
  # @param base_string [String] specifies the +base_string+
  # @see string_of_length string_of_length for exceptions raised.
  # @return [Hash] +Symbol+/+String+ pairs
  #    with keys +:min_length+ and +:max_length+.
  def self.strings_in_length_range(range, base_string=BASE_STRING)
    self.verify_kind_of('range', Range, range)
    {
        :min_length => self.string_of_length(range.first, base_string),
        :max_length => self.string_of_length(range.last, base_string),
    }
  end

  def self.misspelled(string)
    self.verify_kind_of('string', String, string)
    unless string.match(/\w/)
      message = "Can only misspell string matching /\\w/, not '#{string}'"
      raise ArgumentError.new(message)
    end
    misspelling = string.clone
    index = nil
    misspelling.scan(/./).each_with_index do |char, i|
      next unless char.match(/\w/)
      index = i
      break
    end
    char = misspelling[index]
    misspelling[index] = case
                            when ('A'..'Z').include?(char)
                              char == 'Z' ? 'A' : (1 + char.ord).chr
                            when ('a'..'z').include?(char)
                              char == 'z' ? 'a' : (1 + char.ord).chr
                            when ('0'..'9').include?(char)
                              char == '9' ? '0' : (1 + char.ord).chr
                            else
                              'A'
                          end
    misspelling
  end

  # Return a hash of strings not within minimum and maximum length
  # for the given +range+.
  # @param range [Range] specifies the minimum and maximum string lengths.
  # @param base_string [String] specifies the +base_string+
  # @see string_of_length string_of_length for exceptions raised.
  # @return [Hash] +Symbol+/+String+ pairs
  #    with keys +:too_short+ and +:too_long+.
  def self.strings_not_in_length_range(range, base_string=BASE_STRING)
    self.verify_kind_of('range', Range, range)
    {
        :too_short => self.string_of_length(range.first - 1, base_string),
        :too_long => self.string_of_length(range.last + 1, base_string),
    }
  end

  def self.numerics_in_range(range)
    values = NumericValues.numerics_in_range(range)
    values.each_pair do |key, value|
      values.store(key, value.to_s)
    end
    values
  end

  def self.numerics_not_in_range(range)
    values = NumericValues.numerics_not_in_range(range)
    values.each_pair do |key, value|
      values.store(key, value.to_s)
    end
    values
  end

  def self.booleans
    {
        :true => 'true',
        :false => 'false',
    }
  end

  def self.not_strings
    {
        :nil => nil,
        :not_string => 0,
    }
  end

  def self.not_nonempties
    self.not_strings.merge(:empty => '')
  end

  def self.not_uuids
    self.not_nonempties.merge(:invalid_digits => 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')
  end

  def self.not_booleans
    self.not_nonempties.merge(:invalid_word => 'not_boolean')
  end

  def self.not_ip_addresses
    self.not_nonempties.merge(:invalid_digits => 'xxx.xxx.xxx.xxx')
  end

  def self.not_nonnegative_integers
    self.not_nonempties.merge(:negative => '-1')
  end

  def self.not_positive_integers
    self.not_nonnegative_integers.merge(:zero => '0')
  end

end
