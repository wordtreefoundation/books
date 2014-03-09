class RomanNumerals
  RN = {
    1000 => 'M',
    500 => 'D',
    100 => 'C',
    50 => 'L',
    10 => 'X',
    5 => 'V',
    1 => 'I'  
  }
 
  def self.to_roman(decimal)
    return nil if decimal > 3000 || decimal < 1
    return to_roman_loop(decimal)
    # return to_roman_recursive(decimal, 1000)
  end
 
  def self.to_roman_loop(dec)
    roman_base = 1000
    result = ''
    while (dec > 0) do
      factor = dec/roman_base
      result << multiple_of(factor, roman_base)
      dec -= (factor*roman_base)
      roman_base /= 10
    end
    result
  end
 
  def self.to_roman_recursive(dec, roman_base)
    return '' if dec < 1 || roman_base < 1
    return multiple_of(dec/roman_base, roman_base) + to_roman_recursive(dec % roman_base, roman_base/10)
  end
 
  def self.multiple_of(factor, roman_base)
    # p "#{factor}, #{roman_base}"
    case factor
    when 0
      ''
    when 1..3
      RN[roman_base]*factor
    when 4
      RN[roman_base]+RN[roman_base*5]
    when 5
      RN[roman_base*5]
    when 6..8
      RN[roman_base*5]+(RN[roman_base]*(factor-5))
    when 9
      RN[roman_base] + RN[roman_base*10]
    else
      raise "Nonsense! Factor is #{factor}. Should be in (0..9)."
    end
  end
end

puts RomanNumerals.to_roman(ARGV.first.to_i)
