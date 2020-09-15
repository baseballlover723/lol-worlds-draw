require "../../set4"
require "./group"

module Lol::Worlds
  class Draw
    @groups : StaticArray(Group, 4)
    @added_to_group = StaticArray(Bool, 4).new { false }

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

    def clone
      Draw.from_json(to_json)
    end

    def add(team : Team)
      puts ""
      puts "adding team: #{team.name}"
      group = @groups.zip(@added_to_group)
        .reject { |_group, added| added }
        .map { |group, _| group }
        .find { |group| group.can_add?(team) }
        .as(Group)

      @added_to_group[@groups.index(group).as(Int)] = true

      puts "adding to group #{group.to_json}"
      group << team
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
