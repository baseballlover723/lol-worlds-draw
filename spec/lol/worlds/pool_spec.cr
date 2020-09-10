require "../.././spec_helper"

module Lol::Worlds
  describe Pool do
    describe "json" do
      describe "serializes" do
        it "one correctly" do
          Pool::One.to_json.should eq("1")
        end

        it "two correctly" do
          Pool::Two.to_json.should eq("2")
        end

        it "three correctly" do
          Pool::Three.to_json.should eq("3")
        end

        it "four correctly" do
          Pool::Four.to_json.should eq("4")
        end
      end

      describe "deserializes" do
        it "one correctly" do
          Pool.from_json("1").should eq(Pool::One)
        end

        it "two correctly" do
          Pool.from_json("2").should eq(Pool::Two)
        end

        it "three correctly" do
          Pool.from_json("3").should eq(Pool::Three)
        end

        it "four correctly" do
          Pool.from_json("4").should eq(Pool::Four)
        end

        [0, 5].each do |numb|
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
