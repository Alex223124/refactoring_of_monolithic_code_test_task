class RowsToHashServcie

  #initializes an instance variable for further use
  def initialize(array_of_lists)
    @array_of_lists = array_of_lists
  end

  # runs service logic
  def run
    format_hash_values(combine_hash)
  end

  private

  # creates single hash from csv data
  def combine_hash
    merged_hashes = {}
    @array_of_lists.each do |list_of_rows|
      hash = convert_rows_to_hash(list_of_rows)
      merged_hashes = merge_hashes(merged_hashes, hash)
    end
    merged_hashes
  end

  # covnerts rows from csv to hash, validating blank rows
  def convert_rows_to_hash(list_of_rows)
    hash = {}
    list_of_rows.each do |row|
      next if row.nil? || row[0].nil?
      hash[row[0]] = [row[1]]
    end
    hash
  end

  # merges hash values which has same key
  def merge_hashes(h1, h2)
    h1.merge(h2){|k,v1,v2|[v1,v2]}
  end

  # formats hash values from nested arrays to regular arrays
  def format_hash_values(hash)
    hash.each do |key, value|
      hash[key] = value.flatten
    end
    hash
  end

end