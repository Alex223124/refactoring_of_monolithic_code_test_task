require './spec/spec_helper'

describe "command line arguments parser" do

  describe "#initialize" do

    context "when arguments are valid" do

      ARGV = ["five", "1", "0.4"]
      arguments_parser = CommandLineArgumentsParser.new

      it "should set instance varialbes with correct values" do
        expect(arguments_parser.directory).to eq("five")
        expect(arguments_parser.modification_factor).to eq(1)
        expect(arguments_parser.cancellaction_factor).to eq(0.4)
      end

    end

    context "when arguments are invalid" do

      error_message = "Wrong input! directroy: five, modification_factor: , cancellaction_factor: asdadsdsasad.
            Please pass arguments in such order: directory name (string), modification factor (integer or float),
            cancellaction factor (integer or float), for example: ruby run.rb directory_name 1 0.4"

      it "should raise the error" do
        ARGV = ["five", nil, "asdadsdsasad"]
        expect{ CommandLineArgumentsParser.new }.to raise_error(error_message)
      end

    end

  end

  describe "#parse_number" do

    arguments_parser = CommandLineArgumentsParser.allocate

    context "when string contain integer" do

      num = "1"
      result = arguments_parser.send(:parse_number, num)

      it "should return integer with the same value" do
        expect(result).to eq(1)
      end

    end

    context "when string contain float" do

      num = "1.1"
      result = arguments_parser.send(:parse_number, num)

      it "should return float with the same value" do
        expect(result).to eq(1.1)
      end

    end

    context "when string doesnt contain any number" do

      num = "sdadsadsasdsadasads"
      result = arguments_parser.send(:parse_number, num)

      it "should return 0" do
        expect(result).to eq(0)
      end

    end

    context "when string is blank" do

      num = ""
      result = arguments_parser.send(:parse_number, num)

      it "should return 0" do
        expect(result).to eq(0)
      end

    end

    context "when string is not specified" do

      it "should return 0" do
        expect{ arguments_parser.send(:parse_number, nil) }.to raise_error
      end

    end

  end

  describe "#valid_arguments?" do

    arguments_parser = CommandLineArgumentsParser.allocate

    context "when arguments are valid" do

      it "should retrun true" do
        ARGV = ["five", "1", "0.4"]
        expect(arguments_parser.send(:valid_arguments?)).to eq(true)
      end

    end

    context "when arguments are invalid" do

      it "should retrun false" do
        ARGV = ["five", nil, "asdadsdsasad"]
        expect(arguments_parser.send(:valid_arguments?)).to eq(false)
      end

    end

  end

  describe "#arguments_passed?" do

    arguments_parser = CommandLineArgumentsParser.allocate

    context "when arguments are valid" do

      it "should retrun true" do
        ARGV = ["five", "1", "0.4"]
        expect(arguments_parser.send(:arguments_passed?)).to eq(true)
      end

    end

    context "when arguments are invalid" do

      it "should retrun false" do
        ARGV = ["five", nil, "asdadsdsasad"]
        expect(arguments_parser.send(:arguments_passed?)).to eq(false)
      end

    end

  end

  describe "#right_type?" do

    arguments_parser = CommandLineArgumentsParser.allocate

    context "when arguments are valid" do

      it "should retrun true" do
        ARGV = ["five", "1", "0.4"]
        expect(arguments_parser.send(:right_type?)).to eq(true)
      end

    end

    context "when arguments are invalid" do

      it "should retrun false" do
        ARGV = ["five", nil, "asdadsdsasad"]
        expect(arguments_parser.send(:arguments_passed?)).to eq(false)
      end

    end

  end

end
