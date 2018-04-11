class CSVOperations

  # (+)
  LINES_PER_FILE = 120000.freeze
  # (+)
  DEFAULT_CSV_OPTIONS = { :col_sep => "\t", :headers => :first_row }.freeze
  # (+)
  DEFAULT_CSV_WRITE_OPTIONS = DEFAULT_CSV_OPTIONS.merge(:row_sep => "\r\n")

  #parses data from file
  # (+)
  def self.parse(file)
    binding.pry
    CSV.read(file, DEFAULT_CSV_OPTIONS)
  end

  #reads rows from file and then generates an enumerator
  # (+)
  def self.lazy_read(file)
    Enumerator.new do |yielder|
      CSV.foreach(file, DEFAULT_CSV_OPTIONS) do |row|
        yielder.yield(row)
      end
    end
  end

  # изменить названия этих файлов, из названия не понятно что делат один и что делает второй
  # write_content_to_csv
  # saves content to csv file
  # (+)
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
    done = false
    file_index = 0
    file_name = remove_file_extension_from_(output)
    new_file_name = file_name + "_#{file_index}.txt"

    until done do
      CSV.open(new_file_name, "wb", DEFAULT_CSV_WRITE_OPTIONS) do |csv|
        headers_written = false
        line_count = 0
        while line_count < LINES_PER_FILE
          begin
            merged = merger.next
            unless headers_written
              csv << merged.keys
              headers_written = true
              line_count +=1
            end
            csv << merged
            line_count +=1
          rescue StopIteration
            done = true
            break
          end
        end
        file_index += 1
      end
    end
  end


  # (+)
  def self.remove_file_extension_from_(path, file_extension = '.txt')
    path.gsub(file_extension, '')
  end

end