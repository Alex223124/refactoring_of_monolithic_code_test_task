class CSVHelper
  # can be a mixin in future, for now just helper

  LINES_PER_FILE = 120000.freeze
  DEFAULT_CSV_OPTIONS = { col_sep: ',', headers: :first_row }.freeze
  DEFAULT_CSV_WRITE_OPTIONS = DEFAULT_CSV_OPTIONS.merge(:row_sep => "\r\n").freeze

  # reads csv file
  def self.parse(file)
    CSV.read(file, DEFAULT_CSV_OPTIONS)
  end

  # converts csv file to array
  def self.to_array_converter(file)
    rows = []
    CSV.foreach(file, DEFAULT_CSV_OPTIONS) do |row|
      rows << row.to_a
    end
    rows
  end

  # writes sorting result to a new csv file
  def self.write(content, headers, output)
    CSV.open(output, "wb", DEFAULT_CSV_WRITE_OPTIONS) do |csv|
      csv << headers
      content.each do |row|
        csv << row
      end
    end
  end

  # takes a hash and writes it to csv file
  def self.hash_to_csv(hash, file_name)
    file_name = remove_file_extension_from_(file_name)
    new_file_name = file_name + "_recalculated.txt"
    headers = hash.keys
    content = hash.values

    CSV.open(new_file_name, "wb", DEFAULT_CSV_WRITE_OPTIONS) do |csv|
      csv << headers
      csv << content
    end
  end

  # removes the file format from the string
  def self.remove_file_extension_from_(path, file_extension = '.txt')
    path.gsub(file_extension, '')
  end

end