class MyItems

  def initialize
    @items = []
  end

  def add_item(item)
    raise ArgumentError.new(item) unless (4..8).include?(item.length)
    @items.push(item)
  end

end
