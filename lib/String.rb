class String
  def true?
    if self.to_s == "true"
      return true
    else
      return false
    end
  end

  def to_b
    if self.to_s == 'true'
      return true
    else
      return false
    end
  end

  def money
    result = self.to_d.money
    return result.to_s
  end
end