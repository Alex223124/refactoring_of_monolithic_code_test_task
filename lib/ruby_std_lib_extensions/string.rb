class String

  puts "Warning! String class has extensions!"

  # converts a string to a float type, replacing the comma with a period for the correct type conversion
  def from_german_to_f
    self.gsub(',', '.').to_f
  end

end