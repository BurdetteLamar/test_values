class NumericValues < ValuesBase

  def self.numerics_in_range(range)
    self.verify_range_not_empty('range', range)
    self.verify_kind_of('range.first', Numeric, range.first)
    self.verify_kind_of('range.last', Numeric, range.last)
    {
        :min_value => range.first,
        :max_value => range.last
    }
  end

  def self.numerics_not_in_range(range)
    self.verify_range_not_empty('range', range)
    if range.first > range.last
      inverted = true
      first, last = range.last, range.first
    else
      inverted = false
      first, last = range.first, range.last
    end
    case
      when first.respond_to?(:pred)
        too_small = first.pred
      when first.respond_to?(:prev_float)
        self.verify_finite_numeric(inverted ? 'range.last' : 'range.first', first)
        too_small = first.prev_float
      else
        raise TypeError.new(first)
    end
    case
      when last.respond_to?(:succ)
        too_large = last.succ
      when last.respond_to?(:next_float)
        self.verify_finite_numeric(inverted ? 'range.first' : 'range.last', last)
        too_large = last.next_float
      else
        raise ArgumentError.new(last)
    end
    {
        :too_small => too_small,
        :too_large => too_large,
    }
  end

end
