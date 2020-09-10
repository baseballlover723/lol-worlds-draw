require "json"
require "./pool"

module Lol::Worlds
  class Team
    include JSON::Serializable

    property name : String
    property pool : Pool

    def initialize(@name : String, @pool : Pool)
    end

    def initialize(@name : String, pool : Int)
      @pool = Pool.get_pool(pool)
    end
  end
end
