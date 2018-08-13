class StringValues < ValuesBase

  BASE_STRING = 'x'
  # Return a string of the given size.
  # Use trimmed or extended base_string, if given; otherwise 'x' characters.
  def self.string_of_size(size, base_string=BASE_STRING)
    self.verify_class('size', Integer, size)
    self.verify_class('base_string', String, base_string)
    if size < 0
      message = "Parameter size must be nonnegative, not #{size}"
      raise RangeError.new(message)
    end
    return '' if size == 0
    s = base_string
    while s.size < size
      s = s * 2
    end
    return s[0..size-1]
  end

  # Return strings of minimum and maximum length for range.
  def self.strings_in_length_range(range, base_string=BASE_STRING)
    self.verify_class('range', Range, range)
    {
        :min_length => self.string_of_size(range.first, base_string),
        :max_length => self.string_of_size(range.last, base_string),
    }
  end

    # Return string outside of minimum and maximum length for range.
  def self.strings_not_in_length_range(range, base_string=BASE_STRING)
    self.verify_class('range', Range, range)
    {
        :too_short => self.string_of_size(range.first - 1, base_string),
        :too_long => self.string_of_size(range.last + 1, base_string),
    }
  end

end
