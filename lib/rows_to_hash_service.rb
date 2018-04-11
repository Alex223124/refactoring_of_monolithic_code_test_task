class RowsToHashService

  attr_accessor :hash

  def initialize(list_of_rows)
    @list_of_rows = list_of_rows
  end

  # creates hashes from csv input
  def run
    binding.pry
    keys = convert_rows_to_array
    binding.pry
    hash = create_hash_from_(keys)
    binding.pry
    fill_hash(hash)
  end

  private

  # creates array of strings
  def convert_rows_to_array
    binding.pry
    keys = []
    binding.pry
    @list_of_rows.each do |row|
      next if row.nil?
      keys << row[0]
    end
    keys
  end

  # creates hash from array of given keys with blank values
  def create_hash_from_(keys)
    binding.pry
    result = {}
    keys.each do |key|
      result[key] = []
    end
    result
  end

  # adds values to hashes with blank values
  def fill_hash(hash)
    binding.pry
    hash.keys.each do |key|
      @list_of_rows.each do |row|
        hash[key] << (row.nil? ? nil : row[1])
      end
    end
    hash
  end

end