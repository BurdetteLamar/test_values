class StringValues < ValuesBase

  BASE_STRING = 'x'
  # Return a string of the given +size+,
  # built by trimming or extending the given +base_string+.
  # @param size [Integer] the size of the string to be returned.
  # @param base_string [String] the base string to be trimmed or extended.
  # @return [String] a string of the given size.
  # @raise [TypeError] if +size+ is not an +Integer+.
  # @raise [TypeError] if +base_string+ is not a +String+.
  # @raise [RangeError] if +size+ is negative.
  def self.string_of_size(size, base_string=BASE_STRING)
    self.verify_class('size', Integer, size)
    self.verify_class('base_string', String, base_string)
    self.verify_integer_size('size', (0..Float::INFINITY), size)
    return '' if size == 0
    s = base_string
    while s.size < size
      s = s * 2
    end
    return s[0..size-1]
  end

  # Return a hash of strings of minimum and maximum length
  # for the given +range+.
  # @param range [Range] specifies the minimum and maximum string lengths.
  # @param base_string [String] specifies the +base_string+
  # @see string_of_size string_of_size for exceptions raised.
  # @return [Hash] +Symbol+/+String+ pairs
  #    with keys +:min_length+ and +:max_length+.
  def self.strings_in_length_range(range, base_string=BASE_STRING)
    self.verify_class('range', Range, range)
    {
        :min_length => self.string_of_size(range.first, base_string),
        :max_length => self.string_of_size(range.last, base_string),
    }
  end

  # Return a hash of strings not within minimum and maximum length
  # for the given +range+.
  # @param range [Range] specifies the minimum and maximum string lengths.
  # @param base_string [String] specifies the +base_string+
  # @see string_of_size string_of_size for exceptions raised.
  # @return [Hash] +Symbol+/+String+ pairs
  #    with keys +:too_short+ and +:too_long+.
  def self.strings_not_in_length_range(range, base_string=BASE_STRING)
    self.verify_class('range', Range, range)
    {
        :too_short => self.string_of_size(range.first - 1, base_string),
        :too_long => self.string_of_size(range.last + 1, base_string),
    }
  end

end
