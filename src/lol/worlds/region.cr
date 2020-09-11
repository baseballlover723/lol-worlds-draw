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

    def to_json(json : JSON::Builder)
      json.string(self)
    end
  end
end
