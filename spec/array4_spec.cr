require "./spec_helper"

describe Array4 do
  it "is an array" do
    Array4(Int32).new.should be_a(Array(Int32))
  end

  it "can store 4 elements" do
    array = Array4{1, 2, 3, 4}
  end

  it "raises an exception if it grows more then 4 elements big" do
    array = Array4{1, 2, 3, 4}
    expect_raises(IndexError) do
      array << 5
    end
  end

  it "raises an exception if it is initialized with more then 4 elements" do
    expect_raises(IndexError) do
      array = Array4{1, 2, 3, 4, 5}
    end
  end
end
