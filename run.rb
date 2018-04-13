require './lib/helpers/path_helper'

arguments = CommandLineArgumentsParser.new
input = FileInputParser.new(arguments.directory).latest
ModifierService.new(input, arguments.modification_factor, arguments.cancellaction_factor).modify
puts "DONE modifying"