require "../.././spec_helper"

module Lol::Worlds
  describe Group do
    it "is an array" do
      Group.new.should be_a(Array(Team))
    end

    it "can store 4 elements" do
      team = Team.new("TSM", Pool::One, Region::North_America)
      group = Group{team, team, team, team}
      group.size.should eq(4)
    end

    it "raises an exception if it grows more then 4 elements big" do
      team = Team.new("TSM", Pool::One, Region::North_America)
      group = Group{team, team, team, team}
      expect_raises(IndexError) do
        group << team
      end
    end

    it "raises an exception if it is initialized with more then 4 elements" do
      team = Team.new("TSM", Pool::One, Region::North_America)
      expect_raises(IndexError) do
        Group{team, team, team, team, team}
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
        group.to_json.should eq("[{\"name\":\"TSM\",\"pool\":1,\"region\":\"North_America\"}]")
      end
    end

    describe "deserializes" do
      it "can read from a json string" do
        json = [{name: "TSM", pool: 1, region: "North_America"}].to_json
        group = Group.from_json(json)

        group.class.should eq(Group)
        group.size.should eq(1)
        group[0].name.should eq("TSM")
      end

      it "4 teams" do
        team_obj = {name: "TSM", pool: 1, region: "North_America"}
        json = [team_obj, team_obj, team_obj, team_obj].to_json
        group = Group.from_json(json)

        group.class.should eq(Group)
        group.size.should eq(4)
        group[0].name.should eq("TSM")
        group[1].name.should eq("TSM")
        group[2].name.should eq("TSM")
        group[3].name.should eq("TSM")
      end

      it "errors if there are more then 4 teams" do
        team_obj = {name: "TSM", pool: 1, region: "North_America"}
        json = [team_obj, team_obj, team_obj, team_obj, team_obj].to_json

        expect_raises(IndexError) do
          Group.from_json(json)
        end
      end
    end
  end
end
