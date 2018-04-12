class String

  puts "Warning! String class has extensions!"

  # converts a string to a float type, replacing the comma with a period for the correct type conversion
  def from_german_to_f
    self.gsub(',', '.').to_f
  end

  def is_integer?
    self.to_i.to_s == self
  end

  def is_float?
    self.to_f.to_s == self
  end

  def is_number?
    is_float? || is_integer?
  end

end