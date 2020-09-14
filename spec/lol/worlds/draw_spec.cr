require "../.././spec_helper"

module Lol::Worlds
  describe Draw do
    it "is initialized with 4 empty groups" do
      draw = Draw.new
      draw.size.should eq(4)
      draw.each do |group|
        group.size.should eq(0)
      end
    end

    describe "==" do
      it "is equal if they have the same groups" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("Rouge", Pool::Three, Region::Europe)
        draw1 = Draw.new
        draw2 = Draw.new

        draw1[0] << team1
        draw1[1] << team2

        draw2[0] << team1
        draw2[1] << team2

        draw1.should eq(draw2)
      end

      it "is equal if they have the same groups regardless of order" do
        team1 = Team.new("TSM", Pool::One, Region::North_America)
        team2 = Team.new("Rouge", Pool::Three, Region::Europe)
        draw1 = Draw.new
        draw2 = Draw.new

        draw1[1] << team1
        draw1[2] << team2

        draw2[0] << team1
        draw2[1] << team2

        draw1.should eq(draw2)
      end
    end

    it "reserializes to itself" do
      draw = Draw.new
      group1 = draw[0]
      group1 << Team.new("TSM", Pool::One, Region::North_America)
      group2 = draw[1]
      group2 << Team.new("Rouge", Pool::Three, Region::Europe)

      Draw.from_json(draw.to_json).should eq(draw)
    end

    describe "serializes" do
      it "a draw correctly" do
        draw = Draw.new
        group1 = draw[0]
        group1 << Team.new("TSM", Pool::One, Region::North_America)
        group2 = draw[1]
        group2 << Team.new("Rouge", Pool::Three, Region::Europe)

        draw.to_json.should eq("[" + group1.to_json + "," + group2.to_json + ",[],[]]")
      end
    end

    describe "deserializes" do
      it "can read from a json string" do
        group1 = Group{Team.new("TSM", Pool::One, Region::North_America)}
        group2 = Group{Team.new("Rouge", Pool::Three, Region::Europe)}
        json = "[" + group1.to_json + "," + group2.to_json + ",[],[]]"
        draw = Draw.from_json(json)

        draw.size.should eq(4)
        draw_iter = draw.each
        draw_iter.next.as(Group).should eq(group1)
        draw_iter.next.as(Group).should eq(group2)
      end
    end
  end
end
