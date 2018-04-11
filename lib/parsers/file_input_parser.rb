class FileInputParser

  FILES_FOLDER_BASE_URL = "#{ ENV['HOME'] }/workspace/"
  RESTRICTION_FOR_FILE_NAMES = /\d+-\d+-\d+_[[:alpha:]]+\.txt$/
  LAST_DATE_FROM_FILE_NAME = /\d+-\d+-\d+/

  attr_accessor :files

  # initializes files from repository,
  # if given directory path incorrect raises exception
  def initialize(directory)
    @directory = directory
    if @directory
      parse_input
    else
      raise "No directory given. Please specify directory."
    end
  end

  # gets last file by date
  def latest
    sort_by_date_from_file_name
    @files.last
  end

  private

  # checks if given directory exist, if the directory exists,
  # it extracts a list of all files from the directory,
  # in other case (when directory doesnt exist) raises exception
  def parse_input
    directroy_path = FILES_FOLDER_BASE_URL + @directory
    if File.exist?(directroy_path)
      get_files_from_(directroy_path)
    else
      raise "Wrong directroy name, Please use the existing directory name"
    end
  end

  #checks if there are files in the directory, if yes,
  # then the method gets an array of filenames, otherwise it raises the exception
  def get_files_from_(directroy)
    files_path = directroy + "/*"
    if Dir[files_path].any?
      fetch_specific_files(Dir[files_path])
    else
      raise "The directory #{@directroy} is empty. Please use directory with files"
    end
  end

  #selects files that match the pattern, otherwise, raises the exception
  def fetch_specific_files(files)
    @files = files.select{|file| file.match(RESTRICTION_FOR_FILE_NAMES)}
    if @files.any?
      #do nothing
    else
      raise "The directory #{@directroy} doesnt contain correct files.
            Please use this example to correct names of your files:
            'project_2012-07-27_2012-10-10_performancedata'"
    end
  end

  # sorts files by dates that are specified in the file name
  def sort_by_date_from_file_name
    @files.sort_by! do |file|
      last_date = parse_last_date_from_(file)
      DateTime.parse(last_date)
    end
  end

  # parses the latest date from file name
  def parse_last_date_from_(string)
    string.match(LAST_DATE_FROM_FILE_NAME).to_s
  end
end

