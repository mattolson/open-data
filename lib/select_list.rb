# Represents a list of options for a select list, such as dataset categories
class SelectList
  attr_reader :list, :values
  
  def initialize
    @list = []
    @values = {}
  end
  
  def add(id, value)
    @list << [value, id]
    @values[id] = value
  end
  
  def lookup(id)
    @values[id]
  end
end
