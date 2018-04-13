require './lib/helpers/path_helper'

arguments = CommandLineArgumentsParser.new
input = FileInputParser.new(arguments.directory).latest
modifier = ModifierService.new(input, arguments.modification_factor, arguments.cancellaction_factor)
modifier.modify
puts "DONE modifying"