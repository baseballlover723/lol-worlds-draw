require "../../set4"
require "./team"

module Lol::Worlds
  class Group < Set4(Team)
    def can_add?(team : Team)
      puts "checking group #{to_json}" if Lol::Worlds::Sim::VERBOSE
      all? { |t| t.region != team.region }
    end
  end
end
