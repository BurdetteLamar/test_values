class ValuesBase

  def self.verify_class(parameter_name, klass, obj)
    return if obj.kind_of?(klass)
    message = "Parameter #{parameter_name} must be instance of #{klass.name}, not #{obj.inspect}"
    raise TypeError.new(message)
  end

end