require "./lib/file_input_parser"
require "./modifier"
require 'date'


directory = "five"


modified = input = FileInputParser.new(directory).latest
modification_factor = 1
cancellaction_factor = 0.4
modifier = Modifier.new(modification_factor, cancellaction_factor)
modifier.modify(modified, input)

puts "DONE modifying"