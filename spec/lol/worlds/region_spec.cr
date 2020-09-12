require "../.././spec_helper"

module Lol::Worlds
  describe Region do
    describe "json" do
      enums = {
        "\"Brazil\"":        Region::Brazil,
        "\"CIS\"":           Region::CIS,
        "\"China\"":         Region::China,
        "\"Europe\"":        Region::Europe,
        "\"Japan\"":         Region::Japan,
        "\"Korea\"":         Region::Korea,
        "\"Latin_America\"": Region::Latin_America,
        "\"North_America\"": Region::North_America,
        "\"Oceania\"":       Region::Oceania,
        "\"PCS\"":           Region::PCS,
        "\"Turkey\"":        Region::Turkey,
      }

      it "reserializes to itself" do
        region = Region::North_America
        Region.from_json(region.to_json).should eq(region)
      end

      describe "serializes" do
        enums.each do |json_value, object|
          it "#{object} correctly" do
            object.to_json.should eq(json_value.to_s)
          end
        end
      end

      describe "deserializes" do
        enums.each do |json_value, object|
          it "#{object} correctly" do
            Region.from_json(json_value.to_s).should eq(object)
          end
        end

        {"\"\"", "Not_A_Region"}.each do |value|
          it "throws an argument error for #{value}" do
            expect_raises(Exception) do
              Region.from_json(value)
            end
          end
        end
      end
    end
  end
end
