require "./spec_helper"

describe Set4 do
  it "can store 4 elements" do
    set = Set4{1, 2, 3, 4}
    set.size.should eq(4)
  end

  it "raises an exception if it grows more then 4 elements big" do
    set = Set4{1, 2, 3, 4}
    expect_raises(IndexError) do
      set << 5
    end
  end

  it "raises an exception if it grows more then 4 elements big with add" do
    set = Set4{1, 2, 3, 4}
    expect_raises(IndexError) do
      set.add 5
    end
  end

  it "raises an exception if it grows more then 4 elements big with add?" do
    set = Set4{1, 2, 3, 4}
    expect_raises(IndexError) do
      set.add? 5
    end
  end

  it "raises an exception if it is initialized with more then 4 elements" do
    expect_raises(IndexError) do
      Set4{1, 2, 3, 4, 5}
    end
  end

  describe "==" do
    it "is equal if they have the same inner values" do
      set1 = Set4{1}
      set2 = Set4{1}
      set1.should eq(set2)
    end

    it "is equal if they have the same inner values regardless of order" do
      set1 = Set4{1, 2}
      set2 = Set4{2, 1}
      set1.should eq(set2)
    end
  end

  it "reserializes to itself" do
    set = Set4{1, 5}
    Set4(Int32).from_json(set.to_json).should eq(set)
  end

  describe "serializes" do
    it "a set correctly" do
      set = Set4{1, 2}
      set.to_json.should eq("[1,2]")
    end
  end

  describe "deserializes" do
    it "can read from a json string" do
      json = [1, 2, 3].to_json
      set = Set4(Int32).from_json(json)

      set.should eq(Set4{1, 2, 3})
    end

    it "errors if there are more then 4 teams" do
      json = [1, 2, 3, 4, 5].to_json

      expect_raises(IndexError) do
        Set4(Int32).from_json(json)
      end
    end
  end
end
