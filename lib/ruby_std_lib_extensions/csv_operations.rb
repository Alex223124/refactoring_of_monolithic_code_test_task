class CSVOperations

  LINES_PER_FILE = 120000.freeze
  DEFAULT_CSV_OPTIONS = { col_sep: ',', headers: :first_row }.freeze
  DEFAULT_CSV_WRITE_OPTIONS = DEFAULT_CSV_OPTIONS.merge(:row_sep => "\r\n")

  def self.parse(file)
    CSV.read(file, DEFAULT_CSV_OPTIONS)
  end

  # to_a or to_array?
  def self.to_array_converter(file)
    rows = []
    CSV.foreach(file, DEFAULT_CSV_OPTIONS) do |row|
      rows << row.to_a
    end
    rows
  end

  def self.write(content, headers, output)
    CSV.open(output, "wb", DEFAULT_CSV_WRITE_OPTIONS) do |csv|
      csv << headers
      content.each do |row|
        csv << row
      end
    end
  end

  # (+)
  def self.write_to_csv(merger, output)
    file_index = 0
    file_name = remove_file_extension_from_(output)
    new_file_name = file_name + "_#{file_index}.txt"

    CSV.open(new_file_name, "wb", DEFAULT_CSV_WRITE_OPTIONS) do |csv|
      merger.to_a.each {|elem| csv << elem}
    end
    end


  # (+)
  def self.remove_file_extension_from_(path, file_extension = '.txt')
    path.gsub(file_extension, '')
  end

end