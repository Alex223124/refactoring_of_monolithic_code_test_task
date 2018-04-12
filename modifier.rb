require 'pry'

require 'csv'
require 'date'
require "./lib/parsers/file_input_parser"
require "./lib/ruby_std_lib_extensions/float.rb"
require "./lib/ruby_std_lib_extensions/string.rb"
require "./lib/ruby_std_lib_extensions/csv_operations"
require "./lib/services/report_recalculation_service"
require "./lib/services/rows_to_hash_service"

class Modifier

	KEYWORD_UNIQUE_ID = 'Keyword Unique ID'.freeze
	LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze

	# initializes factors fr future usage in sorting
	def initialize(sale_amount_factor, cancellation_factor)
		@sale_amount_factor = sale_amount_factor
		@cancellation_factor = cancellation_factor
	end

	# uses a set of methods for the report's recalculation
	def modify(input)
		input = sort(input)
		array_of_lists = CSVOperations.to_array_converter(input)
		merged_hashes = RowsToHashServcie.new(array_of_lists).run
		recalculated_hash = combine_values_for_(merged_hashes)
		CSVOperations.hash_to_csv(recalculated_hash, input)
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

	private

	#starts the service for the recalculation of incoming program data
	def combine_values_for_(hash)
		ReportRecalculationService.new(hash, @cancellation_factor, @sale_amount_factor).calculate
	end

end
