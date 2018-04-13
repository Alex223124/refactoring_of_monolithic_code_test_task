require 'date'
require 'pry'
require 'csv'

require './lib/parsers/file_input_parser'
require './lib/parsers/command_line_arguments_parser'

require './lib/ruby_std_lib_extensions/csv_operations'
require './lib/ruby_std_lib_extensions/float'
require './lib/ruby_std_lib_extensions/string'

require './lib/services/report_recalculation_service'
require './lib/services/rows_to_hash_service'