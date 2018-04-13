require './spec/spec_helper'

describe "report recalculation service" do

  describe "#initialize" do

    context "when arguments are valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should set instance varialbes with correct values" do
        expect(report.instance_variable_get("@hash")).to eq(hash)
        expect(report.instance_variable_get("@cancellation_factor")).to eq(cancellation_factor)
        expect(report.instance_variable_get("@sale_amount_factor")).to eq(sale_amount_factor)
      end

    end

    context "when arguments are not specified" do

      it "should raise the error" do
        expect{ ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor) }.to raise_error
      end

    end

  end

  describe "#calculate" do

    context "when arguments are valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"], "Keyword"=>["keyword1", "keyword2", "keyword3"],
              "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
              "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
              "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
              "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
              "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
              "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
              "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
              "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
              "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
              "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
              "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
              "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
              "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
              "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
              "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.calculate

      it "should recalculate hash values using logic of other methods" do
        expect(report.instance_variable_get("@hash")).to eq(hash)
      end

    end

    context "when arguments are invalid" do

      hash = {"asa" => nil}
      cancellation_factor = "1asasd"
      sale_amount_factor = ["daasdsdadsadsa"]
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.calculate }.to raise_error
      end

    end

  end

  describe "#set_last_key_as_key" do

    context "arguments is valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"], "Keyword"=>["keyword1", "keyword2", "keyword3"],
              "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
              "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
              "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
              "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
              "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
              "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
              "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
              "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
              "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
              "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
              "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
              "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
              "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
              "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
              "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      new_hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>"3333", "Account ID"=>"12",
                  "Account Name"=>"ExampleAccountNameThree2", "Campaign"=>"ThirdCampaignName3",
                  "Ad Group"=>"ThirdAdGroup3", "Keyword"=>"keyword3", "Keyword Type"=>"KeywordTypeThree3",
                  "Subid"=>"9999", "Paused"=>"FALSE", "Max CPC"=>"5555", "ACCOUNT"=>"AccountThree3",
                  "CAMPAIGN"=>"CampaignThree3", "BRAND"=>"BrandNAmeThree3", "BRAND+CATEGORY"=>"BrandCategoryName3",
                  "ADGROUP"=>"AdGrouThree3", "KEYWORD"=>"keyword3", "Last Avg CPC"=>["222", "333", "4444"],
                  "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
                  "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
                  "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
                  "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
                  "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
                  "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"],
                  "Avg Pos"=>["253", "2525", "3636"], "number of commissions"=>["4233", "3434", "3433"],
                  "Commission Value"=>["344", "3433", "352"], "ACCOUNT - Commission Value"=>["3434", "34443", "3423"],
                  "CAMPAIGN - Commission Value"=>["564", "5645", "645"], "BRAND - Commission Value"=>["5656", "56456", "776"],
                  "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"], "ADGROUP - Commission Value"=>["685567", "65756", "6766"],
                  "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.send(:set_last_key_as_key)

      it "should select the last value from the array, which is stored as
          value in the key-value pairs whose keys are specified in the constant" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs which
            specified in constant" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_last_key_as_key) }.to raise_error
      end


    end

    context "when instance variables are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_last_key_as_key) }.to raise_error
      end

    end

  end

  describe "#set_last_present_value_as_key" do

    context "arguments is valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"], "Keyword"=>["keyword1", "keyword2", "keyword3"],
              "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
              "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
              "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
              "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
              "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
              "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
              "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
              "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
              "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
              "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
              "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
              "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
              "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
              "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
              "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      new_hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
                  "Account ID"=>["10", "11", "12"],
                  "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
                  "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
                  "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"],
                  "Keyword"=>["keyword1", "keyword2", "keyword3"],
                  "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
                  "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
                  "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
                  "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
                  "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
                  "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
                  "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"],
                  "KEYWORD"=>["keyword1", "keyword2", "keyword3"], "Last Avg CPC"=>["222", "333", "4444"],
                  "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
                  "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
                  "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
                  "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
                  "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
                  "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
                  "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
                  "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
                  "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
                  "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should select the value which satisfies given conditions from the array, which is stored as
          value in the key-value pairs whose keys are specified in the constant" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs which
            specified in constant" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_last_present_value_as_key) }.to raise_error
      end

    end

    context "when instance varialbes are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_last_present_value_as_key) }.to raise_error
      end

    end

  end

  describe "#set_first_value_as_key_in_string_format" do

    context "when arguments is valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"], "Keyword"=>["keyword1", "keyword2", "keyword3"],
              "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
              "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
              "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
              "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
              "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
              "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
              "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
              "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
              "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
              "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
              "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
              "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
              "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
              "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
              "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      new_hash = {"Clicks"=>"500", "Keyword Unique ID"=>["1111", "2222", "3333"],
                  "Account ID"=>["10", "11", "12"],
                  "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
                  "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
                  "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"],
                  "Keyword"=>["keyword1", "keyword2", "keyword3"],
                  "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
                  "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"],
                  "Max CPC"=>["3333", "4444", "5555"], "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
                  "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
                  "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
                  "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
                  "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
                  "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"],
                  "Impressions"=>"10", "ACCOUNT - Clicks"=>"1000", "CAMPAIGN - Clicks"=>"21321",
                  "BRAND - Clicks"=>"123123", "BRAND+CATEGORY - Clicks"=>"2312", "ADGROUP - Clicks"=>"23321",
                  "KEYWORD - Clicks"=>"2323", "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"],
                  "Est EPC"=>["342", "23423", "3434"], "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"],
                  "Avg Pos"=>["253", "2525", "3636"], "number of commissions"=>["4233", "3434", "3433"],
                  "Commission Value"=>["344", "3433", "352"], "ACCOUNT - Commission Value"=>["3434", "34443", "3423"],
                  "CAMPAIGN - Commission Value"=>["564", "5645", "645"], "BRAND - Commission Value"=>["5656", "56456", "776"],
                  "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"], "ADGROUP - Commission Value"=>["685567", "65756", "6766"],
                  "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.send(:set_first_value_as_key_in_string_format)

      it "should select the first value from the array, which is stored as
          value in the key-value pairs whose keys are specified in the constant
          and coverts it to string" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs which
            specified in constant" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_first_value_as_key_in_string_format) }.to raise_error
      end

    end

    context "when instance variables are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_first_value_as_key_in_string_format) }.to raise_error
      end

    end

  end

  describe "#set_first_value_as_key_in_float_format" do

    context "when arguments is valid" do

      hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
              "Account ID"=>["10", "11", "12"],
              "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
              "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
              "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"], "Keyword"=>["keyword1", "keyword2", "keyword3"],
              "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
              "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"], "Max CPC"=>["3333", "4444", "5555"],
              "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
              "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
              "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
              "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
              "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"], "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
              "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"], "Impressions"=>["10", "100", "1000"],
              "ACCOUNT - Clicks"=>["1000", "2000", "3000"], "CAMPAIGN - Clicks"=>["21321", "123123", "12321"],
              "BRAND - Clicks"=>["123123", "123123", "213"], "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"],
              "ADGROUP - Clicks"=>["23321", "112331", "32232"], "KEYWORD - Clicks"=>["2323", "5125", "5654"],
              "Avg CPC"=>["756", "5675", "656"], "CTR"=>["23423", "3242", "5675"], "Est EPC"=>["342", "23423", "3434"],
              "newBid"=>["343", "3424", "3443"], "Costs"=>["643", "6362", "235"], "Avg Pos"=>["253", "2525", "3636"],
              "number of commissions"=>["4233", "3434", "3433"], "Commission Value"=>["344", "3433", "352"],
              "ACCOUNT - Commission Value"=>["3434", "34443", "3423"], "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"], "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"], "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      new_hash = {"Clicks"=>["500", "300", "100"], "Keyword Unique ID"=>["1111", "2222", "3333"],
                  "Account ID"=>["10", "11", "12"],
                  "Account Name"=>["ExampleAccountNameOne1", "ExampleAccountNameTwo2", "ExampleAccountNameThree2"],
                  "Campaign"=>["FirstCampaignName1", "SecondCampaignName2", "ThirdCampaignName3"],
                  "Ad Group"=>["FirstAdGroup1", "SecodAdGroup2", "ThirdAdGroup3"],
                  "Keyword"=>["keyword1", "keyword2", "keyword3"],
                  "Keyword Type"=>["KeywordTypeOne1", "KeywordsTypeTwo2", "KeywordTypeThree3"],
                  "Subid"=>["7777", "8888", "9999"], "Paused"=>["TRUE", "TRUE", "FALSE"],
                  "Max CPC"=>["3333", "4444", "5555"],
                  "ACCOUNT"=>["AccountOne1", "AccountTwo2", "AccountThree3"],
                  "CAMPAIGN"=>["CampaignOne1", "CampaignTwo2", "CampaignThree3"],
                  "BRAND"=>["BrandNameOne1", "BrandNameTwo2", "BrandNAmeThree3"],
                  "BRAND+CATEGORY"=>["BrandCategoryName1", "BrandCategoryName2", "BrandCategoryName3"],
                  "ADGROUP"=>["AdgroupOne1", "AdgroupTwo2", "AdGrouThree3"],
                  "KEYWORD"=>["keyword1", "keyword2", "keyword3"],
                  "Last Avg CPC"=>["222", "333", "4444"], "Last Avg Pos"=>["333", "4444", "5555"],
                  "Impressions"=>["10", "100", "1000"], "ACCOUNT - Clicks"=>["1000", "2000", "3000"],
                  "CAMPAIGN - Clicks"=>["21321", "123123", "12321"], "BRAND - Clicks"=>["123123", "123123", "213"],
                  "BRAND+CATEGORY - Clicks"=>["2312", "123323", "12312"], "ADGROUP - Clicks"=>["23321", "112331", "32232"],
                  "KEYWORD - Clicks"=>["2323", "5125", "5654"], "Avg CPC"=>"756,0", "CTR"=>"23423,0", "Est EPC"=>"342,0",
                  "newBid"=>"343,0", "Costs"=>"643,0", "Avg Pos"=>"253,0", "number of commissions"=>["4233", "3434", "3433"],
                  "Commission Value"=>["344", "3433", "352"], "ACCOUNT - Commission Value"=>["3434", "34443", "3423"],
                  "CAMPAIGN - Commission Value"=>["564", "5645", "645"], "BRAND - Commission Value"=>["5656", "56456", "776"],
                  "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"], "ADGROUP - Commission Value"=>["685567", "65756", "6766"],
                  "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.send(:set_first_value_as_key_in_float_format)

      it "should select the first value from the array, which is stored as
          value in the key-value pairs whose keys are specified in the constant
          and coverts it to float and reduces to a tenth" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs which
            specified in constant" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_first_value_as_key_in_float_format) }.to raise_error
      end

    end

    context "when instance variables are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_first_value_as_key_in_float_format) }.to raise_error
      end

    end

  end

  describe "#set_number_of_commissions" do

    context "when arguments is valid" do

      hash = {"number of commissions"=>["4233", "3434", "3433"]}
      new_hash = {"number of commissions"=>"1693,2"}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.send(:set_number_of_commissions)

      it "should calculate number of comissions" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_number_of_commissions) }.to raise_error
      end

    end

    context "when arguments are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_number_of_commissions) }.to raise_error
      end

    end

  end

  describe "#set_values_for_commision_types" do

    context "when arguments is valid" do

      hash = {"Commission Value"=>["344", "3433", "352"], "ACCOUNT - Commission Value"=>["3434", "34443", "3423"],
              "CAMPAIGN - Commission Value"=>["564", "5645", "645"],
              "BRAND - Commission Value"=>["5656", "56456", "776"],
              "BRAND+CATEGORY - Commission Value"=>["646", "6456", "86"],
              "ADGROUP - Commission Value"=>["685567", "65756", "6766"],
              "KEYWORD - Commission Value"=>["545", "564", "4454"]}

      new_hash = {"Commission Value"=>"137,6", "ACCOUNT - Commission Value"=>"1373,6000000000001",
                  "CAMPAIGN - Commission Value"=>"225,60000000000002", "BRAND - Commission Value"=>"2262,4",
                  "BRAND+CATEGORY - Commission Value"=>"258,40000000000003", "ADGROUP - Commission Value"=>"274226,8",
                  "KEYWORD - Commission Value"=>"218,0"}

      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      report.send(:set_values_for_commision_types)

      it "should set new values for comission types specified by the constant" do
        expect(report.instance_variable_get("@hash")).to eq(new_hash)
      end

    end

    context "when hash doesnt contain required key-value pairs which
            specified in constant" do

      hash = {"Clicks"=>["500", "300", "100"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_values_for_commision_types) }.to raise_error
      end


    end

    context "when instance variables are not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:set_values_for_commision_types) }.to raise_error
      end

    end

  end

  describe "#round_up_to_tenth" do

    context "when we have integer inside string" do

      report = ReportRecalculationService.allocate
      given_value = "12142142"
      correct_result = "12142142,0"

      it "should round up to the tenth given value" do
        expect(report.send(:round_up_to_tenth, given_value)).to eq(correct_result)
      end

    end

    context "when we have float inside string" do

      report = ReportRecalculationService.allocate
      given_value = "12142142,0"
      correct_result = "12142142,0"

      it "should round up to the tenth given value" do
        expect(report.send(:round_up_to_tenth, given_value)).to eq(correct_result)
      end

    end

    context "when we have characters inside string" do

      report = ReportRecalculationService.allocate
      given_value = "abc"

      it "should retrun 0,0" do
        expect(report.send(:round_up_to_tenth, given_value)).to eq("0,0")
      end

    end

    context "when we have characters and numbers inside string" do

      report = ReportRecalculationService.allocate
      given_value = "abc4234234"

      it "should retrun 0,0" do
        expect(report.send(:round_up_to_tenth, given_value)).to eq("0,0")
      end

    end

    context "argument is not specified" do

      it "should raise an error" do
        expect{ report.send(:round_up_to_tenth, nil) }.to raise_error
      end

    end

  end

  describe "#calculate_number_of_commissions" do

    context "when we have correct data" do

      hash = {"number of commissions"=>["4233", "3434", "3433"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      correct_result = "1693,2"
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should calculate number of comissions" do
        expect(report.send(:calculate_number_of_commissions)).to eq(correct_result)
      end

    end

    context "when hash doesnt contain required key-value pair" do

      hash = {"some key"=>["4233", "3434", "3433"]}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:calculate_number_of_commissions) }.to raise_error
      end

    end

    context "when instance variables not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:calculate_number_of_commissions) }.to raise_error
      end

    end

  end

  describe "#calculate_value_of_specific_commission_" do

    context "when arguments are valid" do

      type = "Commission Value"
      cancellation_factor = 0.4
      sale_amount_factor = 1
      hash =  {"Commission Value"=>["344", "3433", "352"]}
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)
      correct_result = "137,6"

      it "should recalculate hash values using logic of other methods" do
        expect(report.send(:calculate_value_of_specific_commission_, type)).to eq(correct_result)
      end

    end

    context "when hash doesnt contain required key-value pair" do

      hash = {"asa" => nil}
      cancellation_factor = 0.4
      sale_amount_factor = 1
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should recalculate hash values using logic of other methods" do
        expect{ report.send(:calculate_value_of_specific_commission_, type) }.to raise_error
      end

    end

    context "when instance variables not specified" do

      hash = nil
      cancellation_factor = nil
      sale_amount_factor = nil
      report = ReportRecalculationService.new(hash, cancellation_factor, sale_amount_factor)

      it "should raise an error" do
        expect{ report.send(:calculate_value_of_specific_commission_, type) }.to raise_error
      end

    end

  end

end
