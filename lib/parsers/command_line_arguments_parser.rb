class CommandLineArgumentsParser

  attr_reader :directory, :modification_factor, :cancellaction_factor

  # initializes instance variables from the command-line arguments
  # and checks their correctness, in case of incorrect arguments,
  # it raises the error
  def initialize
    if valid_arguments?
      @directory = ARGV[0]
      @modification_factor = parse_number(ARGV[1])
      @cancellaction_factor = parse_number(ARGV[2])
    else
      raise "Wrong input! directroy: #{ARGV[0]}, modification_factor: #{ARGV[1]}, cancellaction_factor: #{ARGV[2]}.
            Please pass arguments in such order: directory name (string), modification factor (integer or float),
            cancellaction factor (integer or float), for example: ruby run.rb directory_name 1 0.4"
    end
  end

  private

  # converts integer from string to integer or
  # float from string to float
  def parse_number(num)
    if num.is_float?
      num.to_f
    else
      num.to_i
    end
  end

  # checks if arguments are valid
  def valid_arguments?
    arguments_passed? && right_type?
  end

  # checks if arguments are present
  def arguments_passed?
    !!(ARGV[0] && ARGV[1] && ARGV[2])
  end

  # checks if arguments have the correct type
  def right_type?
    ARGV[0].is_a?(String) && ARGV[1].is_number? && ARGV[2].is_number?
  end

end