class ModifierService

	KEYWORD_UNIQUE_ID = 'Keyword Unique ID'.freeze
	LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze

	# initializes factors fr future usage in sorting
	def initialize(input, sale_amount_factor, cancellation_factor)
		@sale_amount_factor = sale_amount_factor
		@cancellation_factor = cancellation_factor
		@input = input
	end

	# uses a set of methods for the report's recalculation
	def modify
		input = sort(@input)
		recalculate(input)
	end

	# sorts the data from csv
	def sort(file)
		output = "#{file}.sorted"
		content_as_table = CSVHelper.parse(file)
		headers = content_as_table.headers
		index_of_key = headers.index('Clicks')
		content = content_as_table.sort_by { |a| -a[index_of_key].to_i }
		CSVHelper.write(content, headers, output)
		output
	end

	# recalculates the data from sorted csv and selects
	# some data by conditions from ReportRecalculationService service
	def recalculate(input)
		array_of_lists = CSVHelper.to_array_converter(input)
		merged_hashes = RowsToHashService.new(array_of_lists).run
		recalculated_hash = combine_values_for_(merged_hashes)
		CSVHelper.hash_to_csv(recalculated_hash, input)
	end

	private

	#starts the service for the recalculation of incoming program data
	def combine_values_for_(hash)
		ReportRecalculationService.new(hash, @cancellation_factor, @sale_amount_factor).calculate
	end

end
