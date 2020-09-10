require "json"

module Lol::Worlds
  enum Region
    Brazil
    CIS
    China
    Europe
    Japan
    Korea
    Latin_America
    North_America
    Oceania
    PCS
    Turkey

    def to_json(io)
      io << '"'
      to_s(io)
      io << '"'
    end
  end
end
