class RowsToHashServcie

  def initialize(array_of_lists)
    @array_of_lists = array_of_lists
  end

  def run
    format_hash_values(combine_hash)
  end

  private

  def combine_hash
    merged_hashes = {}
    @array_of_lists.each do |list_of_rows|
      hash = convert_rows_to_hash(list_of_rows)
      merged_hashes = merge_hashes(merged_hashes, hash)
    end
    merged_hashes
  end

  def convert_rows_to_hash(list_of_rows)
    hash = {}
    list_of_rows.each do |row|
      next if row.nil? || row[0].nil?
      hash[row[0]] = [row[1]]
    end
    hash
  end

  def merge_hashes(h1, h2)
    h1.merge(h2){|k,v1,v2|[v1,v2]}
  end

  def format_hash_values(hash)
    hash.each do |key, value|
      hash[key] = value.flatten
    end
    hash
  end


end