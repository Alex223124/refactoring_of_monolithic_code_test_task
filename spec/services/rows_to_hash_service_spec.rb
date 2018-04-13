require './spec/spec_helper'

describe "report recalculation service" do

  describe "#initialize" do

    context "when arguments are valid" do

      array_of_lists = [[["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"]]]
      service = RowsToHashService.new(array_of_lists)

      it "should set instance varialbes with correct values" do
        expect(service.instance_variable_get("@array_of_lists")).to eq(array_of_lists)
      end

    end

  end

  describe "#run" do

    context "when arguments are valid" do

      array_of_lists = [[["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"],
                         ["Account Name", "ExampleAccountNameOne1"]], [["Clicks", "300"], ["Keyword Unique ID", "2222"],
                         ["Account ID", "11"], ["Account Name", "ExampleAccountNameTwo2"]], [["Clicks", "100"],
                         ["Keyword Unique ID", "3333"], ["Account ID", "12"], ["Account Name", "ExampleAccountNameThree2"]]]

      service = RowsToHashService.new(array_of_lists)
      correct_result = {"Clicks"=>["500", "300", "100"],
                        "Keyword Unique ID"=>["1111", "2222", "3333"],
                        "Account ID"=>["10", "11", "12"],
                        "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"]}

      it "should generate hash with correct values" do
        expect(service.run).to eq(correct_result)
      end

    end

    context "when arguments are invalid" do

      array_of_lists = nil
      service = RowsToHashService.new(array_of_lists)

      it "should raise an error" do
        expect{ service.run }.to raise_error
      end

    end

  end

  describe "#combine_hash" do

    context "when arguments are valid" do

      array_of_lists = [[["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"],
                         ["Account Name", "ExampleAccountNameOne1"]], [["Clicks", "300"], ["Keyword Unique ID", "2222"],
                         ["Account ID", "11"], ["Account Name", "ExampleAccountNameTwo2"]], [["Clicks", "100"],
                         ["Keyword Unique ID", "3333"], ["Account ID", "12"], ["Account Name", "ExampleAccountNameThree2"]]]

      correct_result =  {"Clicks"=>[[["500"], ["300"]], ["100"]],
                         "Keyword Unique ID"=>[[["1111"], ["2222"]], ["3333"]],
                         "Account ID"=>[[["10"], ["11"]], ["12"]],
                         "Account Name"=>[[["ExampleAccountNameOne1"],
                                           ["ExampleAccountNameTwo2"]], ["ExampleAccountNameThree2"]]}

      service = RowsToHashService.new(array_of_lists)

      it "should set instance varialbes with correct values" do
        expect(service.send(:combine_hash)).to eq(correct_result)
      end

    end

     context "when arguments are valid" do

       array_of_lists = nil
       service = RowsToHashService.new(array_of_lists)

       it "should raise an error" do
         expect{ service.send(:combine_hash) }.to raise_error
       end

    end

  end

  describe "#convert_rows_to_hash" do

    context "when arguments are valid" do

      list_of_rows = [[["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"],
                         ["Account Name", "ExampleAccountNameOne1"]], [["Clicks", "300"], ["Keyword Unique ID", "2222"],
                         ["Account ID", "11"], ["Account Name", "ExampleAccountNameTwo2"]], [["Clicks", "100"],
                         ["Keyword Unique ID", "3333"], ["Account ID", "12"], ["Account Name", "ExampleAccountNameThree2"]]]

      correct_result = {["Clicks", "500"]=>[["Keyword Unique ID", "1111"]],
                        ["Clicks", "300"]=>[["Keyword Unique ID", "2222"]],
                        ["Clicks", "100"]=>[["Keyword Unique ID", "3333"]]}

      service = RowsToHashService.allocate

      it "should create correct hash" do
        expect(service.send(:convert_rows_to_hash, list_of_rows)).to eq(correct_result)
      end

    end

    context "when arguments are invalid" do

      list_of_rows = "string"
      service = RowsToHashService.allocate

      it "raise an error" do
        expect{ service.send(:convert_rows_to_hash, list_of_rows) }.to raise_error
      end

    end

  end

  describe "#merge_hashes" do

    context "when arguments are valid" do

      hash_one = {}
      hash_two = {"Clicks"=>["500"], "Keyword Unique ID"=>["1111"], "Account ID"=>["10"],
                  "Account Name"=>["ExampleAccountNameOne1"], "Campaign"=>["FirstCampaignName1"],
                  "Ad Group"=>["FirstAdGroup1"], "Keyword"=>["keyword1"], "Keyword Type"=>["KeywordTypeOne1"],
                  "Subid"=>["7777"]}
      correct_result = {"Clicks"=>["500"], "Keyword Unique ID"=>["1111"], "Account ID"=>["10"],
                        "Account Name"=>["ExampleAccountNameOne1"], "Campaign"=>["FirstCampaignName1"],
                        "Ad Group"=>["FirstAdGroup1"], "Keyword"=>["keyword1"], "Keyword Type"=>["KeywordTypeOne1"],
                        "Subid"=>["7777"]}
      service = RowsToHashService.allocate

      it "should generate hash with correct values" do
        expect(service.send(:merge_hashes, hash_one, hash_two)).to eq(correct_result)
      end

    end

    context "when arguments are invalid" do

      first_argument = "abc"
      second_argument = "1111"
      service = RowsToHashService.allocate

      it "should raise an error" do
        expect{ service.send(:merge_hashes, first_argument, second_argument) }.to raise_error
      end

    end

  end

  describe "#format_hash_values" do

    context "when arguments are invalid" do

      hash = {"Clicks"=>[[["500"], ["300"]], ["100"]],
              "Keyword Unique ID"=>[[["1111"], ["2222"]], ["3333"]],
              "Account ID"=>[[["10"], ["11"]], ["12"]]}
      correct_result = {"Clicks"=>["500", "300", "100"],
                        "Keyword Unique ID"=>["1111", "2222", "3333"],
                        "Account ID"=>["10", "11", "12"]}
      service = RowsToHashService.allocate

      it "should format the hash values so that the arrays become one-dimensional" do
        expect(service.send(:format_hash_values, hash)).to eq(correct_result)
      end

    end

    context "when arguments are invalid" do

      hash = "abc"
      service = RowsToHashService.allocate

      it "should raise an error" do
        expect{ service.send(:format_hash_values, hash) }.to raise_error
      end

    end

  end

end
