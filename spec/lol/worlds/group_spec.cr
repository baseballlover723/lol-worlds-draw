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
  end
end
