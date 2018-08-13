class StringValues < ValuesBase

  # Return a string of the given size.
  # Use trimmed or extended base_string, if given; otherwise 'x' characters.
  def self.string_of_size(size, base_string='x')
    self.verify_class('size', Integer, size)
    self.verify_class('base_string', String, base_string)
    if size < 0
      message = "Parameter size must be nonnegative, not #{size}"
      raise ArgumentError.new(message)
    end
    return '' if size == 0
    s = base_string
    while s.size < size
      s = s * 2
    end
    return s[0..size-1]
  end

end