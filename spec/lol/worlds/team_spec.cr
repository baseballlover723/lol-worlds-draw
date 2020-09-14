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

    describe "==" do
      it "is equal if they have the same attributes" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("TSM", Pool::One, Region::North_America)
        team1.should eq(team2)
      end

      it "is not equal if they have different names" do
        team1 = Team.new("JD Gaming", Pool::Two, Region::China)
        team2 = Team.new("Suning", Pool::Two, Region::China)
        team1.should_not eq(team2)
      end

      it "is not equal if they have different pools" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("Team Liquid", Pool::Two, Region::North_America)
        team1.should_not eq(team2)
      end

      it "is not equal if they have different regions" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("G2", Pool::One, Region::Europe)
        team1.should_not eq(team2)
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
