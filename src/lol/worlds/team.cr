require "json"
require "./pool"
require "./region"

module Lol::Worlds
  class Team
    include JSON::Serializable

    property name : String
    property pool : Pool
    property region : Region

    def initialize(@name : String, @pool : Pool, @region : Region)
    end

    def initialize(@name : String, pool : Int, @region : Region)
      @pool = Pool.from_json(pool.to_s)
    end
  end
end
