class ValuesBase

  private

  def self.verify_kind_of(parameter_name, klass, obj)
    return true if obj.kind_of?(klass)
    message = "Parameter #{parameter_name} must be instance of #{klass.name}, not #{obj.inspect}"
    raise TypeError.new(message)
  end

  def self.verify_integer_in_range(parameter_name, range, obj)
    self.verify_kind_of(parameter_name, Integer, obj)
    return true if range.include?(obj)
    message = "Parameter #{parameter_name} must be in range #{range}, not #{obj}"
    raise RangeError.new(message)
  end

  def self.verify_finite_numeric(parameter_name, obj)
    self.verify_kind_of(parameter_name, Numeric, obj)
    if obj.kind_of?(Float)
      unless obj.finite?
        message = "Parameter #{parameter_name} must be finite, not #{obj}"
        raise ArgumentError.new(message)
      end
    end
  end

end
