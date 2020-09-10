require "../.././spec_helper"

module Lol::Worlds
  describe Pool do
    describe "json" do
      enums = {"1": Pool::One, "2": Pool::Two, "3": Pool::Three, "4": Pool::Four}

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
            Pool.from_json(json_value.to_s).should eq(object)
          end
        end

        {0, 5}.each do |numb|
          it "throws an argument error for #{numb}" do
            expect_raises(Exception) do
              Pool.from_json(numb.to_s)
            end
          end
        end
      end
    end
  end
end
