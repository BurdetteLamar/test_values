class ValuesBase

  private

  def self.verify_class(parameter_name, klass, obj)
    return true if obj.kind_of?(klass)
    message = "Parameter #{parameter_name} must be instance of #{klass.name}, not #{obj.inspect}"
    raise TypeError.new(message)
  end

  def self.verify_integer_size(parameter_name, range, obj)
    self.verify_class(parameter_name, Integer, obj)
    return true if range.include?(obj)
    message = "Parameter #{parameter_name} must be in range #{range}, not #{obj}"
    raise RangeError.new(message)
  end

end
