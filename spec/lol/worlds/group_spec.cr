require "../.././spec_helper"

module Lol::Worlds
  describe Group do
    it "is a set4 of Teams" do
      Group.new.should be_a(Set4(Team))
    end
  end
end
