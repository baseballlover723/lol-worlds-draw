require "../.././spec_helper"

module Lol::Worlds
  describe Team do
    describe "initialize" do
      it "initializes successfully" do
        team = Team.new("TSM", Pool::One, Region::North_America)

        team.name.should eq("TSM")
        team.pool.should eq(Pool::One)
        team.region.should eq(Region::North_America)
      end

      it "initializes with a pool as an enum" do
        team = Team.new("TSM", Pool::One, Region::North_America)

        team.pool.should eq(Pool::One)
      end

      it "initializes with a pool as an int" do
        team = Team.new("TSM", 1, Region::North_America)

        team.pool.should eq(Pool::One)
      end
    end
  end
end
