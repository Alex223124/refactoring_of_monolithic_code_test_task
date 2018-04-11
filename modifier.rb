require 'pry'

require 'csv'
require 'date'
require "./lib/parsers/file_input_parser"
require "./lib/ruby_std_lib_extensions/float.rb"
require "./lib/ruby_std_lib_extensions/string.rb"
require "./lib/ruby_std_lib_extensions/csv_operations"
require "./lib/services/rows_to_hash_service"
require "./lib/services/report_recalculation_service"

class Modifier

	KEYWORD_UNIQUE_ID = 'Keyword Unique ID'.freeze
	LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze

	# initializes factors fr future usage in sorting
	def initialize(sale_amount_factor, cancellation_factor)
		@sale_amount_factor = sale_amount_factor
		@cancellation_factor = cancellation_factor
	end

	# uses a set of methods for the report's recalculation
	def modify(output, input)
		input = sort(input)
		input_enumerator = CSVOperations.lazy_read(input)
		merger = enumerate_list_of_rows(input_enumerator)
		CSVOperations.write_to_csv(merger, output)
	end

	# sorts the data for the subsequent recalculation of the values of certain indicators
	def sort(file)
		output = "#{file}.sorted"
		content_as_table = CSVOperations.parse(file)
		headers = content_as_table.headers
		index_of_key = headers.index('Clicks')
		content = content_as_table.sort_by { |a| -a[index_of_key].to_i }
		CSVOperations.write(content, headers, output)
		output
	end

	# updates the value of the received data using the application services
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

	private

	# (+)
	#starts the service for the recalculation of incoming program data
	def combine_values_for_(hash)
		ReportRecalculationService.new(hash, @cancellation_factor, @sale_amount_factor).calculate
	end

end
