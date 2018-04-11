class FileInputParser

  FILES_FOLDER_BASE_URL = "#{ ENV['HOME'] }/workspace/"

  attr_accessor :files

  def initialize(directory)
    if directory
      @files = parse_input(directory)
    else
      raise "No directory given. Please specify directory."
    end
  end

  def latest
    sort_by_date_from_file_name
    @files.last
  end

  private

  def parse_input(directory)
    directroy_path = FILES_FOLDER_BASE_URL + "#{directory}"
    if File.exist?(directroy_path)
      get_files_from_(directroy_path)
    else
      raise "Wrong directroy name, Please use the existing directory name"
    end
  end

  def get_files_from_(directroy)
    files_path = directroy + "/*"
    if Dir[files_path].any?
      Dir[files_path]
    else
      raise "The directory #{directroy} is empty. Please use directory with files"
    end
  end

  def sort_by_date_from_file_name
    @files.sort_by! do |file|
      last_date = (/\d+-\d+-\d+_[[:alpha:]]+\.txt$/).match(file)
      last_date = last_date.to_s.match(/\d+-\d+-\d+/)
      date = DateTime.parse(last_date.to_s)
      date
    end
  end

end

