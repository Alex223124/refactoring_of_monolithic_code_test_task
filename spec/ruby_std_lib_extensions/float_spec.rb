require './spec/spec_helper'

describe "float" do

  describe "#to_german_s" do

    float_number = 1.1

    it "should convert float value to a string" do
      expect(float_number).to be_a(Float)
      expect(float_number.to_german_s).to be_a(String)
    end

    it "should replace the point with a floating point" do
      expect(float_number.to_s.include?(".")).to eq(true)
      expect(float_number.to_german_s.include?(".")).to eq(false)
      expect(float_number.to_german_s.include?(",")).to eq(true)
    end

  end

end