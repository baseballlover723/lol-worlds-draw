require "../../set4"
require "./group"

module Lol::Worlds
  class Draw
    @groups : StaticArray(Group, 4)

    def initialize
      @groups = StaticArray(Group, 4).new { Group.new }
    end

    def initialize(@groups : StaticArray(Group, 4))
    end

    # JSON stuff
    def self.new(pull : JSON::PullParser)
      ary = new
      new(pull) do |element, index|
        ary[index] = element
      end
      ary
    end

    def self.new(pull : JSON::PullParser)
      index = 0
      pull.read_array do
        yield Group.new(pull), index
        index += 1
      end
    end

    def to_json(json : JSON::Builder)
      json.array do
        each &.to_json(json)
      end
    end

    # slow
    def ==(other)
      @groups.to_set == other.groups.to_set
    end

    protected def groups
      @groups
    end

    forward_missing_to @groups
  end
end
