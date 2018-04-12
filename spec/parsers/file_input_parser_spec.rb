require './spec/spec_helper'

describe "file input parser" do

  FileInputParser.const_set("FILES_FOLDER_BASE_URL", "#{Dir.pwd}/sample_data/workspace/")
  
  describe "#initialize" do

    context "when directroy name is correct" do

      directory_name = "example_directory"
      file_input_parser = FileInputParser.new(directory_name)
      correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt"]

      it "should set @files instance varialbe with list of files" do
        expect(file_input_parser.files).to eq(correct_value)
      end

    end

    context "when directroy name is incorrect" do

      incorrect_directroy_name = "111111111111111111111"
      error_message = "Wrong directroy name: 111111111111111111111, Please use the existing directory name"

      it "should raise an error" do
        expect{ FileInputParser.new(incorrect_directroy_name) }.to raise_error(error_message)
      end

    end

    context "when directroy name is blank" do

      blank_directory_name = ""
      errors_message = "No directory given. Please specify directory."

      it "should raise an error" do
        expect{ FileInputParser.new(blank_directory_name) }.to raise_error(errors_message)
      end

    end

    context "when directroy name is not specified" do

      errors_message = "No directory given. Please specify directory."

      it "should raise an error" do
        expect{ FileInputParser.new(nil) }.to raise_error(errors_message)
      end

    end

  end

  describe "#latest" do

    context "when @files varialbe containt correct data" do

      file_input_parser = FileInputParser.allocate
      correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt"]
      file_input_parser.instance_variable_set("@files", correct_value)
      latest = "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt"

      it "should select the newest by date (from the file name) file" do
        expect(file_input_parser.latest).to eq(latest)
      end

    end

    context "when @files varialbe containt incorrect data" do

      file_input_parser = FileInputParser.allocate
      incorrect_value = "11111111111"
      file_input_parser.instance_variable_set("@files", incorrect_value)

      it "should raise an error" do
        expect{ file_input_parser.latest }.to raise_error
      end

    end

    context "when @files varialbe is not specified" do

      file_input_parser = FileInputParser.allocate
      file_input_parser.instance_variable_set("@files", nil)

      it "should raise an error" do
        expect{ file_input_parser.latest }.to raise_error
      end

    end

  end

  describe "#parse_input" do

    context "when directroy path is correct" do

      directory_name = "example_directory"
      file_input_parser = FileInputParser.allocate
      file_input_parser.instance_variable_set("@directory", directory_name)
      file_input_parser.send(:parse_input)
      correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt"]

      it "should get am array of files from directroy" do
        expect(file_input_parser.files).to eq(correct_value)
      end

    end

    context "when directroy path is incorrect" do

      directory_name = "111111111111111111111111"
      file_input_parser = FileInputParser.allocate
      file_input_parser.instance_variable_set("@directory", directory_name)
      error_message = "Wrong directroy name: 111111111111111111111111, Please use the existing directory name"

      it "should raise the error" do
        expect{ file_input_parser.send(:parse_input) }.to raise_error(error_message)

      end

    end

    context "when directroy path is not specified" do

      file_input_parser = FileInputParser.allocate
      file_input_parser.instance_variable_set("@directory", nil)
      error_message = "Wrong directroy name: , Please use the existing directory name"

      it "should raise the error" do
        expect{ file_input_parser.send(:parse_input) }.to raise_error(error_message)
      end

    end

  end

  describe "#get_files_from_(directory)" do

    context "when directroy name is correct" do

      directory_name = "example_directory"
      directory = FileInputParser.const_get("FILES_FOLDER_BASE_URL") + directory_name
      file_input_parser = FileInputParser.allocate
      correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt"]
      file_input_parser.send(:get_files_from_, directory)

      it "should get array of files from directory" do
        expect(file_input_parser.files).to eq(correct_value)
      end

    end

    context "when directroy name is incorrect" do

      directory_name = "111111111111111111111"
      directory = FileInputParser.const_get("FILES_FOLDER_BASE_URL") + directory_name
      file_input_parser = FileInputParser.allocate

      it "should get array of files from directory" do
        expect{file_input_parser.send(:get_files_from_, directory)}.to raise_error
      end

    end

    context "when directroy name is not specified" do

      file_input_parser = FileInputParser.allocate

      it "should get array of files from directory" do
        expect{file_input_parser.send(:get_files_from_, nil)}.to raise_error
      end

    end

  end

  describe "#fetch_specific_(files)" do

    context "when directroy contains files with correct names" do

      file_input_parser = FileInputParser.allocate
      files = correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt",
                               "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                               "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt"]
      file_input_parser.send(:fetch_specific_, files)


      it "should select files which match regex pattern" do
        expect(file_input_parser.files).to eq(correct_value)
      end

    end

    context "when directroy contains files with incorrect names" do

      file_input_parser = FileInputParser.allocate
      files = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/323rerwetw3w32.txt",
              "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/234wtewe3wew3wew3t2.txt",
              "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/sada33r23rwr33rw3rw3rw3r.txt"]
      error_message = "The directory  doesnt contain correct files.
            Please use this example to correct names of your files:
            'project_2012-07-27_2012-10-10_performancedata'"

      it "should raise the error" do
        expect{file_input_parser.send(:fetch_specific_, files)}.to raise_error(error_message)
      end

    end

    context "when directroy doesnt contains any files" do

      file_input_parser = FileInputParser.allocate
      files = []
      error_message = "The directory  doesnt contain correct files.
            Please use this example to correct names of your files:
            'project_2012-07-27_2012-10-10_performancedata'"

      it "should raise the error" do
        expect{file_input_parser.send(:fetch_specific_, files)}.to raise_error(error_message)
      end

    end

    context "when files are not specified" do
      file_input_parser = FileInputParser.allocate

      it "should raise the error" do
        expect{file_input_parser.send(:fetch_specific_, nil)}.to raise_error
      end

    end

  end

  describe "#sort_by_date_from_file_name" do

    context "when directroy contains files with correct names" do

      directory_name = "example_directory"
      file_input_parser = FileInputParser.new(directory_name)
      correct_value = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2011-07-27_2011-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2012-07-27_2012-10-10_performancedata.txt",
                       "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}example_directory/project_2013-07-27_2013-10-10_performancedata.txt"]
      file_input_parser.send(:sort_by_date_from_file_name)

      it "should sort files inside array in rigth order" do
        expect(file_input_parser.files).to eq(correct_value)
      end

    end

    context "when directroy contains files with incorrect names" do

      file_input_parser = FileInputParser.allocate
      files = ["#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/323rerwetw3w32.txt",
              "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/234wtewe3wew3wew3t2.txt",
              "#{FileInputParser.const_get('FILES_FOLDER_BASE_URL')}directory_with_incorrect_filenames/sada33r23rwr33rw3rw3rw3r.txt"]
      file_input_parser.instance_variable_set("@files", files)

      it "should sort files inside array in rigth order" do
        expect{ file_input_parser.send(:sort_by_date_from_file_name) }.to raise_error
      end

    end

    context "when files are note specified" do

      file_input_parser = FileInputParser.allocate
      file_input_parser.instance_variable_set("@files", nil)

      it "should sort files inside array in rigth order" do
        expect{ file_input_parser.send(:sort_by_date_from_file_name) }.to raise_error
      end

    end

  end

  describe "#parse_last_date_from_(string)" do

    context "when given filename is correct" do

      filename = "project_2013-07-27_2013-10-10_performancedata.txt"
      correct_result ="2013-07-27"
      file_input_parser = FileInputParser.allocate

      it "should parse last date from given string using regrexp" do
        expect(file_input_parser.send(:parse_last_date_from_,filename)).to eq(correct_result)
      end

    end

    context "when given filename is incorrect" do

      filename = "asfafasfasfafs"
      file_input_parser = FileInputParser.allocate

      it "should retrun blank string" do
        expect(file_input_parser.send(:parse_last_date_from_,filename)).to eq("")
      end

    end

    context "when filename is not specified" do

      filename = nil
      file_input_parser = FileInputParser.allocate

      it "should retrun blank string" do
        expect{ file_input_parser.send(:parse_last_date_from_,filename) }.to raise_error
      end

    end

  end

end