require "./team"

module Lol::Worlds
  class Group < Array(Team)
    def initialize
      super(4)
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
      super(element)
    end
  end
end
