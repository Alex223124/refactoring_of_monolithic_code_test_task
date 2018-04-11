require 'pry'

require File.expand_path('lib/combiner',File.dirname(__FILE__))
require 'csv'
require 'date'
require "./lib/file_input_parser"
require "./lib/standard_classes_extensions/float.rb"
require "./lib/standard_classes_extensions/string.rb"
require "./lib/csv_operations"
require "./lib/rows_to_hash_service"
require "./lib/report_recalculation_service"

class Modifier

	KEYWORD_UNIQUE_ID = 'Keyword Unique ID'.freeze
	LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze

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

	def enumerate_list_of_rows(combiner)
		Enumerator.new do |yielder|
			while true
				begin
					list_of_rows = combiner.next
					merged_hashes = RowsToHashService.new(list_of_rows).run
					yielder.yield(combine_values_for_(merged_hashes))
				rescue StopIteration
					break
				end
			end
		end
	end

	def modify(output, input)
		input = sort(input)
		input_enumerator = CSVOperations.lazy_read(input)
		merger = enumerate_list_of_rows(input_enumerator)
		CSVOperations.write_to_csv(merger, output)
	end

	private

	# combine what?
	def combine(merged)
		result = []

		# do we need don't care variable here?
		merged.each do |_, hash|
			result << combine_values_for_(hash)
		end
		result
	end

	def combine_values_for_(hash)
		ReportRecalculationService.new(hash, @cancellation_factor, @sale_amount_factor).calculate
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
