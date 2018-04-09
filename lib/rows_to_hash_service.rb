class RowsToHashService

  attr_accessor :hash

  def initialize(list_of_rows)
    @list_of_rows = list_of_rows
  end

  # creates hashes from csv input
  def run
    keys = convert_rows_to_array
    hash = create_hash_from_(keys)
    fill_hash(hash)
  end

  private

  # creates array of strings
  def convert_rows_to_array
    keys = []
    @list_of_rows.each do |row|
      next if row.nil?
      row.headers.each do |key|
        keys << key
      end
    end
    keys
  end

  # creates hash from array of given keys with blank values
  def create_hash_from_(keys)
    result = {}
    keys.each do |key|
      result[key] = []
    end
    result
  end

  # adds values to hashes with blank values
  def fill_hash(hash)
    hash.keys.each do |key|
      @list_of_rows.each do |row|
        hash[key] << (row.nil? ? nil : row[key])
      end
    end
    hash
  end

end