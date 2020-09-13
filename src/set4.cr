class Set4(T)
  @inner : Set(T)

  def initialize
    @inner = Set(T).new(4)
  end

  # JSON stuff
  def self.new(pull : JSON::PullParser)
    ary = new
    new(pull) do |element|
      ary << element
    end
    ary
  end

  def self.new(pull : JSON::PullParser)
    pull.read_array do
      yield T.new(pull)
    end
  end

  def <<(element : T)
    raise IndexError.new("a Group can only have 4 teams") if size >= 4
    @inner << element
    self
  end

  def ==(other)
    @inner == other.inner
  end

  protected def inner
    @inner
  end

  forward_missing_to @inner
end
