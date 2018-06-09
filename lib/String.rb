# Useful String methods for Jeweler: .true?, .to_b and .money
class String
  # Returns true if the string is equal to 'true'
  def true?
    to_s == 'true'
  end

  # Returns true if String is explicitly equal to 'true'
  # Returns false if String is explicitly equal to 'false'
  # raise ArgumentError if any other String is evaluated
  def to_b
    if to_s == 'true'
      true
    elsif to_s == 'false'
      false
    else
      # raise SyntaxError
      raise ArgumentError 'String being evaluated by to_b can only be equal to True or False'
    end
  end

  # Parses a number by converting it to a Double, formatting
  # it as money, and then converting it back to String
  # Example: $32.50 (String)
  def money
    to_d.money.to_s
  end
end