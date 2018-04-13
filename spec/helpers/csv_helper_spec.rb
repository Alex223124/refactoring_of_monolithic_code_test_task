require './spec/spec_helper'

describe "scv helper" do

  describe "#self.parse" do

    context "when given file path is correct" do

      correct_output = [["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"], ["Account Name", "ExampleAccountNameOne1"],
                        ["Campaign", "FirstCampaignName1"], ["Ad Group", "FirstAdGroup1"], ["Keyword", "keyword1"],
                        ["Keyword Type", "KeywordTypeOne1"], ["Subid", "7777"], ["Paused", "TRUE"], ["Max CPC", "3333"],
                        ["ACCOUNT", "AccountOne1"], ["CAMPAIGN", "CampaignOne1"], ["BRAND", "BrandNameOne1"],
                        ["BRAND+CATEGORY", "BrandCategoryName1"], ["ADGROUP", "AdgroupOne1"], ["KEYWORD", "keyword1"],
                        ["Last Avg CPC", "222"], ["Last Avg Pos", "333"], ["Impressions", "10"], ["ACCOUNT - Clicks", "1000"],
                        ["CAMPAIGN - Clicks", "21321"], ["BRAND - Clicks", "123123"], ["BRAND+CATEGORY - Clicks", "2312"],
                        ["ADGROUP - Clicks", "23321"], ["KEYWORD - Clicks", "2323"], ["Avg CPC", "756"], ["CTR", "23423"],
                        ["Est EPC", "342"], ["newBid", "343"], ["Costs", "643"], ["Avg Pos", "253"],
                        ["number of commissions", "4233"], ["Commission Value", "344"], ["ACCOUNT - Commission Value", "3434"],
                        ["CAMPAIGN - Commission Value", "564"], ["BRAND - Commission Value", "5656"],
                        ["BRAND+CATEGORY - Commission Value", "646"], ["ADGROUP - Commission Value", "685567"],
                        ["KEYWORD - Commission Value", "545"], [nil, "4565"], [nil, "456456"], [nil, "34534"], [nil, "4534"]]

      FileInputParser.const_set("FILES_FOLDER_BASE_URL", "#{Dir.pwd}/sample_data/workspace/")
      file = "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt"
      csv = CSVHelper.parse(file)

      it "should read file and retrun correct csv" do
        expect(csv[0].to_a).to eq(correct_output)
      end

    end

    context "when given file path is incorrect" do

      file = "1111111111111111111.txt"

      it "should read file and retrun correct csv" do
        expect{ CSVHelper.parse(file) }.to raise_error
      end

    end

  end

  describe "#self.to_array_converter" do

    context "when given file path is correct" do

      correct_output = [["Clicks", "500"], ["Keyword Unique ID", "1111"], ["Account ID", "10"], ["Account Name", "ExampleAccountNameOne1"],
                        ["Campaign", "FirstCampaignName1"], ["Ad Group", "FirstAdGroup1"], ["Keyword", "keyword1"],
                        ["Keyword Type", "KeywordTypeOne1"], ["Subid", "7777"], ["Paused", "TRUE"], ["Max CPC", "3333"],
                        ["ACCOUNT", "AccountOne1"], ["CAMPAIGN", "CampaignOne1"], ["BRAND", "BrandNameOne1"],
                        ["BRAND+CATEGORY", "BrandCategoryName1"], ["ADGROUP", "AdgroupOne1"], ["KEYWORD", "keyword1"],
                        ["Last Avg CPC", "222"], ["Last Avg Pos", "333"], ["Impressions", "10"], ["ACCOUNT - Clicks", "1000"],
                        ["CAMPAIGN - Clicks", "21321"], ["BRAND - Clicks", "123123"], ["BRAND+CATEGORY - Clicks", "2312"],
                        ["ADGROUP - Clicks", "23321"], ["KEYWORD - Clicks", "2323"], ["Avg CPC", "756"], ["CTR", "23423"],
                        ["Est EPC", "342"], ["newBid", "343"], ["Costs", "643"], ["Avg Pos", "253"],
                        ["number of commissions", "4233"], ["Commission Value", "344"], ["ACCOUNT - Commission Value", "3434"],
                        ["CAMPAIGN - Commission Value", "564"], ["BRAND - Commission Value", "5656"], ["BRAND+CATEGORY - Commission Value", "646"],
                        ["ADGROUP - Commission Value", "685567"], ["KEYWORD - Commission Value", "545"], [nil, "4565"],
                        [nil, "456456"], [nil, "34534"], [nil, "4534"]]

      FileInputParser.const_set("FILES_FOLDER_BASE_URL", "#{Dir.pwd}/sample_data/workspace/")

      file = "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt"
      array = CSVHelper.to_array_converter(file)

      it "should read file and retrun correct csv" do
        expect(array[0]).to eq(correct_output)
      end

    end

    context "when given file path is incorrect" do

      file = "11111111111111.txt"

      it "should read file and retrun correct csv" do
        expect{ CSVHelper.to_array_converter(file) }.to raise_error
      end

    end

  end

  describe "#self.write" do

    context "when we have correct data" do

      content = [["Clicks", "300"], ["Keyword Unique ID", "2222"], ["Account ID", "11"], ["Account Name", "ExampleAccountNameTwo2"],
                 ["Campaign", "SecondCampaignName2"], ["Ad Group", "SecodAdGroup2"], ["Keyword", "keyword2"],
                 ["Keyword Type", "KeywordsTypeTwo2"], ["Subid", "8888"], ["Paused", "TRUE"], ["Max CPC", "4444"],
                 ["ACCOUNT", "AccountTwo2"], ["CAMPAIGN", "CampaignTwo2"], ["BRAND", "BrandNameTwo2"], ["BRAND+CATEGORY", "BrandCategoryName2"],
                 ["ADGROUP", "AdgroupTwo2"], ["KEYWORD", "keyword2"], ["Last Avg CPC", "333"], ["Last Avg Pos", "4444"],
                 ["Impressions", "100"], ["ACCOUNT - Clicks", "2000"], ["CAMPAIGN - Clicks", "123123"], ["BRAND - Clicks", "123123"],
                 ["BRAND+CATEGORY - Clicks", "123323"], ["ADGROUP - Clicks", "112331"], ["KEYWORD - Clicks", "5125"],
                 ["Avg CPC", "5675"], ["CTR", "3242"], ["Est EPC", "23423"], ["newBid", "3424"], ["Costs", "6362"],
                 ["Avg Pos", "2525"], ["number of commissions", "3434"], ["Commission Value", "3433"],
                 ["ACCOUNT - Commission Value", "34443"], ["CAMPAIGN - Commission Value", "5645"],
                 ["BRAND - Commission Value", "56456"], ["BRAND+CATEGORY - Commission Value", "6456"],
                 ["ADGROUP - Commission Value", "65756"], ["KEYWORD - Commission Value", "564"],
                 [nil, "4546"], [nil, "43434"], [nil, "43534"], [nil, "43534"]]

      headers = ["Clicks", "Keyword Unique ID", "Account ID", "Account Name", "Campaign", "Ad Group", "Keyword", "Keyword Type",
                 "Subid", "Paused", "Max CPC", "ACCOUNT", "CAMPAIGN", "BRAND", "BRAND+CATEGORY", "ADGROUP", "KEYWORD",
                 "Last Avg CPC", "Last Avg Pos", "Impressions", "ACCOUNT - Clicks", "CAMPAIGN - Clicks", "BRAND - Clicks",
                 "BRAND+CATEGORY - Clicks", "ADGROUP - Clicks", "KEYWORD - Clicks", "Avg CPC", "CTR", "Est EPC", "newBid",
                 "Costs", "Avg Pos", "number of commissions", "Commission Value", "ACCOUNT - Commission Value",
                 "CAMPAIGN - Commission Value", "BRAND - Commission Value", "BRAND+CATEGORY - Commission Value",
                 "ADGROUP - Commission Value", "KEYWORD - Commission Value", nil, nil, nil, nil]

      Object.const_set("FILES_FOLDER_BASE_URL", "#{Dir.pwd}/sample_data/workspace/")
      directory_name = FILES_FOLDER_BASE_URL + "example_directory"
      file_name = "project_2013-07-27_2013-10-10_performancedata.txt.sorted"
      output = path_to_file = directory_name + "/" + file_name

      it "should generate file with given name" do
        expect(Dir[path_to_file].any?).to eq(false)
        CSVHelper.write(content, headers, output)
        expect(Dir[path_to_file].any?).to eq(true)
        File.delete(path_to_file)
      end

      it "should generate file with correct headers" do
        CSVHelper.write(content, headers, output)
        headers_from_csv = CSV.read(output)[0]
        expect(headers_from_csv).to eq(headers)
        File.delete(path_to_file)
      end

      it "should generate file with correct content" do
        CSVHelper.write(content, headers, output)
        content_from_csv = CSV.foreach(output).drop(1)
        expect(content_from_csv).to eq(content)
        File.delete(path_to_file)
      end

    end

    context "when we have incorrect data" do

      content = 1
      headers = "sadadsadsds"
      output = ""

      it "should raise an error" do
        expect{ CSVHelper.write(content, headers, output) }.to raise_error
      end

    end

    context "when arguments are not specified" do

      it "should raise an error" do
        expect{ CSVHelper.write(nil, nil, nil) }.to raise_error
      end

    end

  end

  describe "#self.hash_to_csv" do

    context "when we have correct data" do

      hash = {"Clicks"=>"500", "Keyword Unique ID"=>"3333", "Account ID"=>"12", "Account Name"=>"ExampleAccountNameThree2",
              "Campaign"=>"ThirdCampaignName3", "Ad Group"=>"ThirdAdGroup3", "Keyword"=>"keyword3",
              "Keyword Type"=>"KeywordTypeThree3", "Subid"=>"9999", "Paused"=>"FALSE", "Max CPC"=>"5555",
              "ACCOUNT"=>"AccountThree3", "CAMPAIGN"=>"CampaignThree3", "BRAND"=>"BrandNAmeThree3",
              "BRAND+CATEGORY"=>"BrandCategoryName3", "ADGROUP"=>"AdGrouThree3", "KEYWORD"=>"keyword3", "Last Avg CPC"=>"4444",
              "Last Avg Pos"=>"5555", "Impressions"=>"10", "ACCOUNT - Clicks"=>"1000", "CAMPAIGN - Clicks"=>"21321",
              "BRAND - Clicks"=>"123123", "BRAND+CATEGORY - Clicks"=>"2312", "ADGROUP - Clicks"=>"23321",
              "KEYWORD - Clicks"=>"2323", "Avg CPC"=>"756,0", "CTR"=>"23423,0", "Est EPC"=>"342,0", "newBid"=>"343,0",
              "Costs"=>"643,0", "Avg Pos"=>"253,0", "number of commissions"=>"1693,2", "Commission Value"=>"137,6",
              "ACCOUNT - Commission Value"=>"1373,6000000000001", "CAMPAIGN - Commission Value"=>"225,60000000000002",
              "BRAND - Commission Value"=>"2262,4", "BRAND+CATEGORY - Commission Value"=>"258,40000000000003",
              "ADGROUP - Commission Value"=>"274226,8", "KEYWORD - Commission Value"=>"218,0"}

      content = [["500", "3333", "12", "ExampleAccountNameThree2", "ThirdCampaignName3", "ThirdAdGroup3", "keyword3",
                  "KeywordTypeThree3", "9999", "FALSE", "5555", "AccountThree3", "CampaignThree3", "BrandNAmeThree3",
                  "BrandCategoryName3", "AdGrouThree3", "keyword3", "4444", "5555", "10", "1000", "21321", "123123",
                  "2312", "23321", "2323", "756,0", "23423,0", "342,0", "343,0", "643,0", "253,0", "1693,2", "137,6",
                  "1373,6000000000001", "225,60000000000002", "2262,4", "258,40000000000003", "274226,8", "218,0"]]

      headers = ["Clicks", "Keyword Unique ID", "Account ID", "Account Name", "Campaign", "Ad Group", "Keyword", "Keyword Type",
                 "Subid", "Paused", "Max CPC", "ACCOUNT", "CAMPAIGN", "BRAND", "BRAND+CATEGORY", "ADGROUP", "KEYWORD",
                 "Last Avg CPC", "Last Avg Pos", "Impressions", "ACCOUNT - Clicks", "CAMPAIGN - Clicks", "BRAND - Clicks",
                 "BRAND+CATEGORY - Clicks", "ADGROUP - Clicks", "KEYWORD - Clicks", "Avg CPC", "CTR", "Est EPC", "newBid",
                 "Costs", "Avg Pos", "number of commissions", "Commission Value", "ACCOUNT - Commission Value",
                 "CAMPAIGN - Commission Value", "BRAND - Commission Value", "BRAND+CATEGORY - Commission Value",
                 "ADGROUP - Commission Value", "KEYWORD - Commission Value"]

      Object.const_set("FILES_FOLDER_BASE_URL", "#{Dir.pwd}/sample_data/workspace/")
      directory_name = FILES_FOLDER_BASE_URL + "sorted_test_data"

      pervious_file_name = "project_2013-07-27_2013-10-10_performancedata.txt.sorted"
      path_to_file = directory_name + "/" + pervious_file_name

      new_file_name = "project_2013-07-27_2013-10-10_performancedata.sorted_recalculated.txt"
      path_to_new_file = directory_name + "/" + new_file_name

      it "should generate file with given name" do
        expect(Dir[path_to_new_file].any?).to eq(false)
        CSVHelper.hash_to_csv(hash, path_to_file)
        expect(Dir[path_to_new_file].any?).to eq(true)
        File.delete(path_to_new_file)
      end

      it "should generate file with correct headers" do
        CSVHelper.hash_to_csv(hash, path_to_file)
        headers_from_csv = CSV.read(path_to_new_file)[0]
        expect(headers_from_csv).to eq(headers)
        File.delete(path_to_new_file)
      end

      it "should generate file with correct content" do
        CSVHelper.hash_to_csv(hash, path_to_file)
        content_from_csv = CSV.foreach(path_to_new_file).drop(1)
        expect(content_from_csv).to eq(content)
        File.delete(path_to_new_file)
      end

    end

    context "when we have incorrect data" do

      hash = nil
      path_to_file = "11111111111111111111111.txt"

      it "should raise an error" do
        expect{ CSVHelper.hash_to_csv(hash, path_to_file) }.to raise_error
      end

    end

    context "when arguments are not specified" do

      it "should raise an error" do
        expect{ CSVHelper.write(nil, nil, nil) }.to raise_error
      end

    end

  end

  describe "#self.remove_file_extension_from_(path)" do

    context "when we have correct data" do

      path = "example_foldex/example_file.txt"
      correct_result = "example_foldex/example_file"

      it "should remove '.txt. postfix from filename'" do
        expect(CSVHelper.remove_file_extension_from_(path)).to eq(correct_result)
      end

    end

    context "when we have incorrect data" do

      path = 124124124124

      it "should raise an error" do
        expect{ CSVHelper.remove_file_extension_from_(path) }.to raise_error
      end

    end

    context "when arguments are not specified" do

      it "should raise an error" do
        expect{ CSVHelper.remove_file_extension_from_(nil) }.to raise_error
      end

    end

  end

end