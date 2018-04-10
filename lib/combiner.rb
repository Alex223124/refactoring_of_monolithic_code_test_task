# input:
# - two enumerators returning elements sorted by their key
# - block calculating the key for each element
# - block combining two elements having the same key or a single element, if there is no partner
# output:
# - enumerator for the combined elements
class Combiner

	def initialize(&key_extractor)
		@key_extractor = key_extractor
	end

	def combine(*enumerators)
		Enumerator.new do |yielder|
			last_values = Array.new(enumerators.size)
			done = enumerators.all? { |enumerator| enumerator.nil? }
			while not done
				last_values.each_with_index do |value, index|

					# method
					if value.nil? and not enumerators[index].nil?
						begin
							last_values[index] = enumerators[index].next
						rescue StopIteration
							enumerators[index] = nil
						end
					end

				end

				done = check_enumerators_and_last_values(enumerators, last_values)

				unless done

					min_key = get_keys_from_csv(last_values).min do |a, b|

						# method
						if a.nil? and b.nil?
							0
						elsif a.nil?
							1
						elsif b.nil?
							-1
						else
							a <=> b
						end

					end
					values = Array.new(last_values.size)

					# method
					last_values.each_with_index do |value, index|
						if get_key(value) == min_key
							values[index] = value
							last_values[index] = nil
						end
					end

					yielder.yield(values)
				end
			end
		end
	end

	private

	def get_key(value)
		@key_extractor.call(value) if value
	end

	def get_keys_from_csv(last_values)
		last_values.map { |e| get_key(e) }
	end

	def check_enumerators_and_last_values(ens, lvs)
		ens.all? { |enumerator| enumerator.nil? } and lvs.compact.empty?
	end


end