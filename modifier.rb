require 'pry'

require File.expand_path('lib/combiner',File.dirname(__FILE__))
require 'csv'
require 'date'
require "./lib/file_input_parser"
require "./lib/standard_classes_extensions/float.rb"
require "./lib/standard_classes_extensions/string.rb"
require "./lib/csv_operations"
require "./lib/rows_to_hash_service"

class Modifier

	KEYWORD_UNIQUE_ID = 'Keyword Unique ID'.freeze
	LAST_VALUE_WINS = ['Account ID', 'Account Name', 'Campaign', 'Ad Group', 'Keyword', 'Keyword Type',
										 'Subid', 'Paused', 'Max CPC', 'Keyword Unique ID', 'ACCOUNT', 'CAMPAIGN', 'BRAND',
										 'BRAND+CATEGORY', 'ADGROUP', 'KEYWORD'].freeze
	LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze
	INT_VALUES = ['Clicks', 'Impressions', 'ACCOUNT - Clicks', 'CAMPAIGN - Clicks', 'BRAND - Clicks',
								'BRAND+CATEGORY - Clicks', 'ADGROUP - Clicks', 'KEYWORD - Clicks'].freeze
	FLOAT_VALUES = ['Avg CPC', 'CTR', 'Est EPC', 'newBid', 'Costs', 'Avg Pos'].freeze
  LINES_PER_FILE = 120000.freeze
	CANCELLATION_FACTOR = ['number of commissions'].freeze
	CANCELLATION_AND_SALE_AMOUNT_FACTOR = ['Commission Value', 'ACCOUNT - Commission Value',
																				 'CAMPAIGN - Commission Value', 'BRAND - Commission Value',
																				 'BRAND+CATEGORY - Commission Value', 'ADGROUP - Commission Value',
																				 'KEYWORD - Commission Value'].freeze

	def initialize(sale_amount_factor, cancellation_factor)
		@sale_amount_factor = sale_amount_factor
		@cancellation_factor = cancellation_factor
	end

	def sort(file)
		output = "#{file}.sorted"
		content_as_table = CSVOperations.parse(file)
		headers = content_as_table.headers
		index_of_key = headers.index('Clicks')
		content = content_as_table.sort_by { |a| -a[index_of_key].to_i }
		CSVOperations.write(content, headers, output)
		output
	end


	def combine_enumerator(input_enumerator)
		Combiner.new do |value|
			value[KEYWORD_UNIQUE_ID]
		end.combine(input_enumerator)
	end

	def enumerate_list_of_rows(combiner)
		Enumerator.new do |yielder|
			while true
				begin
					list_of_rows = combiner.next
					merged = RowsToHashService.new(list_of_rows).run
					yielder.yield(combine_values(merged))
				rescue StopIteration
					break
				end
			end
		end
	end


	def modify(output, input)
		input = sort(input)
		input_enumerator = CSVOperations.lazy_read(input)
		combiner = combine_enumerator(input_enumerator)
		merger = enumerate_list_of_rows(combiner)

    done = false
    file_index = 0
    file_name = output.gsub('.txt', '')

    while !done do
		  CSV.open(file_name + "_#{file_index}.txt", "wb", { :col_sep => "\t", :headers => :first_row, :row_sep => "\r\n" }) do |csv|
			  headers_written = false
        line_count = 0
			  while line_count < LINES_PER_FILE
				  begin
					  merged = merger.next
					  if not headers_written
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

	private

	# combine what?
	def combine(merged)
		result = []

		# do we need don't care variable here?
		merged.each do |_, hash|
			result << combine_values(hash)
		end
		result
	end

	def combine_values(hash)
		# we rebuilding hash here
		LAST_VALUE_WINS.each do |key|
			# key has last?
			hash[key] = hash[key].last
		end

		LAST_REAL_VALUE_WINS.each do |key|
			# remove "not" and "or"
			hash[key] = hash[key].select {|v| not (v.nil? or v == 0 or v == '0' or v == '')}.last
		end

		INT_VALUES.each do |key|
			hash[key] = hash[key][0].to_s
		end

		FLOAT_VALUES.each do |key|
			# useless - from_german_to_f.to_german_s ?
			hash[key] = hash[key][0].from_german_to_f.to_german_s
		end

		CANCELLATION_FACTOR.each do |key|
			hash[key] = (@cancellation_factor * hash[key][0].from_german_to_f).to_german_s
		end

		CANCELLATION_AND_SALE_AMOUNT_FACTOR.each do |key|
			hash[key] = (@cancellation_factor * @sale_amount_factor * hash[key][0].from_german_to_f).to_german_s
		end

		hash
	end


end

# name it "run" and put in separate folder
directory = "four"

modified = input = FileInputParser.new(directory).latest
modification_factor = 1
cancellaction_factor = 0.4
modifier = Modifier.new(modification_factor, cancellaction_factor)
modifier.modify(modified, input)

puts "DONE modifying"
