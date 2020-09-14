require "../.././spec_helper"

module Lol::Worlds
  describe Group do
    it "is a set4 of Teams" do
      Group.new.should be_a(Set4(Team))
    end

    describe "==" do
      it "is equal if they have the same teams" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("Rouge", Pool::Three, Region::Europe)
        group1 = Group{team1, team2}
        group2 = Group{team1, team2}
        group1.should eq(group2)
      end

      it "is equal if they have the same teams regardless of order" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("Rouge", Pool::Three, Region::Europe)
        group1 = Group{team1, team2}
        group2 = Group{team2, team1}
        group1.should eq(group2)
      end
    end

    it "reserializes to itself" do
      group = Group{Team.new("TSM", Pool::One, Region::North_America)}
      Group.from_json(group.to_json).should eq(group)
    end

    describe "serializes" do
      it "a group correctly" do
        team = Team.new("TSM", Pool::One, Region::North_America)
        group = Group{team}
        group.to_json.should eq("[" + team.to_json + "]")
      end
    end

    describe "deserializes" do
      it "can read from a json string" do
        team = Team.new("TSM", Pool::One, Region::North_America)
        json = "[" + team.to_json + "]"
        group = Group.from_json(json)

        group.size.should eq(1)
        group.each.next.as(Team).should eq(team)
      end
    end
  end
end
