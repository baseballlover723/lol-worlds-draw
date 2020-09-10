require "../.././spec_helper"
require "lol/worlds/pool"

module Lol::Worlds
  describe Pool do
    it "gives one for 1" do
      Pool.get_pool(1).should eq(Pool::One)
    end

    it "gives two for 2" do
      Pool.get_pool(2).should eq(Pool::Two)
    end

    it "gives three for 3" do
      Pool.get_pool(3).should eq(Pool::Three)
    end

    it "gives four for 4" do
      Pool.get_pool(4).should eq(Pool::Four)
    end

    [0, 5].each do |numb|
      it "throws an argument error if for #{numb}" do
        expect_raises(ArgumentError) do
          Pool.get_pool(numb)
        end
      end
    end
  end
end
