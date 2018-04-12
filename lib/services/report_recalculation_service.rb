class ReportRecalculationService
  # recalculates and selects right data for report

  LAST_VALUE_WINS = ['Account ID', 'Account Name',
                     'Campaign', 'Ad Group', 'Keyword',
                     'Keyword Type', 'Subid', 'Paused',
                     'Max CPC', 'Keyword Unique ID',
                     'ACCOUNT', 'CAMPAIGN', 'BRAND',
                     'BRAND+CATEGORY', 'ADGROUP', 'KEYWORD'].freeze

  LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze

  INT_VALUES = ['Clicks', 'Impressions',
                'ACCOUNT - Clicks', 'CAMPAIGN - Clicks',
                'BRAND - Clicks', 'BRAND+CATEGORY - Clicks',
                'ADGROUP - Clicks', 'KEYWORD - Clicks'].freeze

  FLOAT_VALUES = ['Avg CPC', 'CTR', 'Est EPC', 'newBid',
                  'Costs', 'Avg Pos'].freeze

  COMISSION_TYPES = ['Commission Value', 'ACCOUNT - Commission Value',
                     'CAMPAIGN - Commission Value', 'BRAND - Commission Value',
                     'BRAND+CATEGORY - Commission Value', 'ADGROUP - Commission Value',
                     'KEYWORD - Commission Value'].freeze

  # initializes the instance variables for further use
  def initialize(hash, cancellation_factor, sale_amount_factor)
    @hash = hash
    @cancellation_factor = cancellation_factor
    @sale_amount_factor = sale_amount_factor
  end

  # overwrites the values of the received data in accordance with the specified logic of supporting methods
  def calculate
    set_last_key_as_key
    set_last_present_value_as_key
    set_first_value_as_key_in_string_format
    set_first_value_as_key_in_float_format
    set_number_of_commissions
    set_values_for_commision_types
    @hash
  end

  private

  # assigns the last hash value as the single to
  # the same key-value pair specified in the constant
  def set_last_key_as_key
    LAST_VALUE_WINS.each {|key| @hash[key] = @hash[key].last}
  end

  # assigns the last hash value which satisfy conditions
  # to the same key-value pair specified in the constant
  def set_last_present_value_as_key
    LAST_REAL_VALUE_WINS.each do |key|
      @hash[key] = @hash[key].select {|v| !(v.nil? || (v == 0) || (v == '0') || (v == ''))}.last
    end
  end

  # assigns the first value value as a string
  # to the same key-value pair specified in the constant
  def set_first_value_as_key_in_string_format
    INT_VALUES.each {|key| @hash[key] = @hash[key][0].to_s}
  end

  # assigns the first value rounded to the tenth
  # to the same key-value pair specified in the constant
  def set_first_value_as_key_in_float_format
    FLOAT_VALUES.each {|key| @hash[key] = round_up_to_tenth(@hash[key][0])}
  end

  # assigns a new value to the key-value pair
  # with the 'number of commissions' key
  def set_number_of_commissions
    @hash["number of commissions"] = calculate_number_of_commissions(@cancellation_factor, @hash)
  end

  # assigns new values to the pairs from
  # the hash which specified in the constant
  def set_values_for_commision_types
    COMISSION_TYPES.each do |key|
      @hash[key] = calculate_value_of_specific_commission_(key, @cancellation_factor, @sale_amount_factor, @hash)
    end
  end

  # rounds the value to the tenth
  def round_up_to_tenth(value)
    value.from_german_to_f.to_german_s
  end

  # calculates the number of commissions
  def calculate_number_of_commissions(cancellation_factor, hash)
    (cancellation_factor * hash["number of commissions"][0].from_german_to_f).to_german_s
  end

  # calculates the value for a certain type of commission
  def calculate_value_of_specific_commission_(type, cancellation_factor, sale_amount_factor, hash)
    (cancellation_factor * sale_amount_factor * hash[type][0].from_german_to_f).to_german_s
  end

end