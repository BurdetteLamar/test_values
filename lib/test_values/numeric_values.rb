class NumericValues < ValuesBase

  def self.numerics_in_range(range)
    self.verify_kind_of('range', Range, range)
    self.verify_kind_of('range.first', Numeric, range.first)
    self.verify_kind_of('range.last', Numeric, range.last)
    {
        :min_value => range.first,
        :max_value => range.last
    }
  end

  def self.numerics_not_in_range(range)
    self.verify_kind_of('range', Range, range)
    if range.first.kind_of?(Integer)
      too_small = range.first.pred
    else
      self.verify_finite_numeric('range.first', range.first)
      too_small = range.first.prev_float
    end
    if range.last.kind_of?(Integer)
      too_large = range.last.succ
    else
      self.verify_finite_numeric('range.last', range.last)
      too_large = range.last.next_float
    end
    {
        :too_small => too_small,
        :too_large => too_large,
    }
  end

end
