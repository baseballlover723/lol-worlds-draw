class Array4(T) < Array(T)
  def initialize
    super(4)
  end

  def <<(element : T)
    raise IndexError.new("Array4 can only hold 4 elements") if size >= 4
    super(element)
  end
end
