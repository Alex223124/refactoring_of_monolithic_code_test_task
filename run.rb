require "./lib/parsers/file_input_parser"
require "./lib/parsers/command_line_arguments_parser"
require "./lib/services/modifier_service"
require 'date'

arguments = CommandLineArgumentsParser.new
input = FileInputParser.new(arguments.directory).latest
modifier = ModifierService.new(input, arguments.modification_factor, arguments.cancellaction_factor)
modifier.modify
puts "DONE modifying"