require "words_from_numbers/version"

module WordsFromNumbers

	def self.subhundred number
	  ones = %w{zero one two three four five six seven eight nine
	            ten eleven twelve thirteen fourteen fifteen
	            sixteen seventeen eighteen nineteen}
	  tens = %w{zero ten twenty thirty fourty fifty sixty seventy eighty ninety}
	  
	  subhundred = number % 100
	  return [ones[subhundred]] if subhundred < 20
	  return [tens[subhundred / 10], ones[subhundred % 10]]
	end

	def self.subthousand number	 
	
	  hundreds = (number % 1000) / 100
	  tens = number % 100
	  s = []	 
	  s = s + subhundred(hundreds) + ["hundred"] unless hundreds == 0
	  s = s + ["and"] unless hundreds == 0 or tens == 0
	  s = s + [subhundred(tens)] unless tens == 0
	  puts "#{s}"
	  s
	end

	def self.decimals number
	  return [] unless number.to_s['.']
	  number = number.to_s.split('.')[1]  
	 
	  digits =  subhundred number.to_i if number.to_i > 0
	  #digits.present? ? ["and"] + digits + ['cents'] : []
	   digits.present? ? [" and"] +  ['cents']  + digits : []  
	end

	def self.words_from_numbers number
	  steps = [""] + %w{thousand million billion trillion quadrillion quintillion sextillion}
	  result = []
	  n = number.to_i
	  steps.each do |step|
	    x = n % 1000
	    unit = (step == "") ? [] : [step]	   
	    result = subthousand(x) + unit  + result unless x == 0   
	    n = n / 1000
	  end
	  result = ["zero"] if result.empty?	
	  result.join(' ').gsub('zero','').strip  	  
	end

end
