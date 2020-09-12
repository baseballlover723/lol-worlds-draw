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

    it "reserializes to itself" do
      team = Team.new("TSM", Pool::One, Region::North_America)
      Team.from_json(team.to_json).should eq(team)
    end

    describe "serializes" do
      it "a team correctly" do
        team = Team.new("TSM", Pool::One, Region::North_America)
        team.to_json.should eq("{\"name\":\"TSM\",\"pool\":1,\"region\":\"North_America\"}")
      end
    end

    describe "deserializes" do
      it "can read all of the seeds" do
        seeds = File.read("files/seeds.json")
        Array(Team).from_json(seeds)
      end

      it "can read from a json string" do
        json = {name: "TSM", pool: 1, region: "North_America"}.to_json
        team = Team.from_json(json)

        team.name.should eq("TSM")
        team.pool.should eq(Pool::One)
        team.region.should eq(Region::North_America)
      end
    end
  end
end
