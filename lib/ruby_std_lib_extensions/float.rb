class Float

  puts "Warning! Float class has extensions!"

  # converts the float value to a string with the same value and replaces the point with a floating point
  def to_german_s
    self.to_s.gsub('.', ',')
  end

end