class FileInputParser

  FILES_FOLDER_BASE_URL = "#{ ENV["HOME"] }/workspace/"

  attr_accessor :files

  def initialize(filename)
    if filename
      @files = parse_input(filename)
    else
      raise "No file given. Please specify filename."
    end
  end

  private

  def parse_input(filename)
    path = FILES_FOLDER_BASE_URL + "/*#{filename}*.txt"
    if File.exist?(path)
      Dir[path]
    else
      raise "Wrong file name, Please use the existing file name from the input_files folder"
    end
  end

end

