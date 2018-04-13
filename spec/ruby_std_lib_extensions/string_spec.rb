require './spec/spec_helper'

describe "string" do

  describe "#from_german_to_f" do

    float_inside_the_stirng = "1,1"

    it "should convert string value to a float" do
      expect(float_inside_the_stirng).to be_a(String)
      expect(float_inside_the_stirng.from_german_to_f).to be_a(Float)
    end

    it "should replace the floating point with a point" do
      expect(float_inside_the_stirng.to_s.include?(",")).to eq(true)
      expect(float_inside_the_stirng.from_german_to_f.to_s.include?(",")).to eq(false)
      expect(float_inside_the_stirng.from_german_to_f.to_s.include?(".")).to eq(true)
    end

  end

  describe "#is_integer?" do

    context "when given string contain integer" do

      integer_inside_string = "1"

      it "should retrun true" do
        expect(integer_inside_string.is_integer?).to eq(true)
      end

    end

    context "when given string contain only characters" do

      string = "abc"

      it "should retrun false" do
        expect(string.is_integer?).to eq(false)
      end

    end

    context "when given string contain integers and characters" do

      integer_and_characters_inside_string = "111aaa"

      it "should retrun false" do
        expect(integer_and_characters_inside_string.is_integer?).to eq(false)
      end

    end

    context "when given string contain float" do

      float_inside_string = "1.1"

      it "should retrun float" do
        expect(float_inside_string.is_integer?).to eq(false)
      end

    end

  end

  describe "#is_float?" do

    context "when given string contain float" do

      float_inside_string = "1.1"

      it "should retrun true" do
        expect(float_inside_string.is_float?).to eq(true)
      end

    end

    context "when given string contain integer" do

      integer_inside_string = "1"

      it "should retrun false" do
        expect(integer_inside_string.is_float?).to eq(false)
      end

    end

    context "when given string contain only characters" do

      string = "abc"

      it "should retrun false" do
        expect(string.is_float?).to eq(false)
      end

    end

    context "when given string contain integers and characters" do

      integer_and_characters_inside_string = "111aaa"

      it "should retrun false" do
        expect(integer_and_characters_inside_string.is_float?).to eq(false)
      end

    end

  end

  describe "#is_number?" do

    context "when given string contain float" do

      float_inside_string = "1.1"

      it "should retrun true" do
        expect(float_inside_string.is_number?).to eq(true)
      end

    end

    context "when given string contain integer" do

      integer_inside_string = "1"

      it "should retrun false" do
        expect(integer_inside_string.is_number?).to eq(true)
      end

    end

    context "when given string contain only characters" do

      string = "abc"

      it "should retrun false" do
        expect(string.is_number?).to eq(false)
      end

    end

    context "when given string contain integers and characters" do

      integer_and_characters_inside_string = "111aaa"

      it "should retrun false" do
        expect(integer_and_characters_inside_string.is_number?).to eq(false)
      end

    end

  end

end