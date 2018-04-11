class ReportRecalculationService

  LAST_VALUE_WINS = ['Account ID', 'Account Name', 'Campaign', 'Ad Group', 'Keyword', 'Keyword Type',
                     'Subid', 'Paused', 'Max CPC', 'Keyword Unique ID', 'ACCOUNT', 'CAMPAIGN', 'BRAND',
                     'BRAND+CATEGORY', 'ADGROUP', 'KEYWORD'].freeze
  LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos'].freeze
  INT_VALUES = ['Clicks', 'Impressions', 'ACCOUNT - Clicks', 'CAMPAIGN - Clicks', 'BRAND - Clicks',
                'BRAND+CATEGORY - Clicks', 'ADGROUP - Clicks', 'KEYWORD - Clicks'].freeze
  FLOAT_VALUES = ['Avg CPC', 'CTR', 'Est EPC', 'newBid', 'Costs', 'Avg Pos'].freeze
  COMISSION_TYPES = ['Commission Value', 'ACCOUNT - Commission Value',
                     'CAMPAIGN - Commission Value', 'BRAND - Commission Value',
                     'BRAND+CATEGORY - Commission Value', 'ADGROUP - Commission Value',
                     'KEYWORD - Commission Value'].freeze

  def initialize(hash, cancellation_factor, sale_amount_factor)
    @hash = hash
    @cancellation_factor = cancellation_factor
    @sale_amount_factor = sale_amount_factor
  end

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

  def set_last_key_as_key
    LAST_VALUE_WINS.each do |key|
      @hash[key] = @hash[key].last
    end
  end

  def set_last_present_value_as_key
    LAST_REAL_VALUE_WINS.each do |key|
      @hash[key] = @hash[key].select {|v| !(v.nil? || (v == 0) || (v == '0') || (v == ''))}.last
    end
  end

  def set_first_value_as_key_in_string_format
    INT_VALUES.each do |key|
      @hash[key] = @hash[key][0].to_s
    end
  end

  def set_first_value_as_key_in_float_format
    FLOAT_VALUES.each do |key|
      @hash[key] = round_up_to_tenth(@hash[key][0])
    end
  end

  def set_number_of_commissions
    @hash["number of commissions"] = calculate_number_of_commissions(@cancellation_factor, @hash)
  end

  def set_values_for_commision_types
    COMISSION_TYPES.each do |key|
      @hash[key] = calculate_value_of_specific_commission_(key, @cancellation_factor, @sale_amount_factor, @hash)
    end
  end

  def round_up_to_tenth(value)
    value.from_german_to_f.to_german_s
  end

  def calculate_number_of_commissions(cancellation_factor, hash)
    (cancellation_factor * hash["number of commissions"][0].from_german_to_f).to_german_s
  end

  def calculate_value_of_specific_commission_(type, cancellation_factor, sale_amount_factor, hash)
    (cancellation_factor * sale_amount_factor * hash[type][0].from_german_to_f).to_german_s
  end

end