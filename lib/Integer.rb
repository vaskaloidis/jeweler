class Integer
  def to_b
    if self == 0
      return false
    else
      return true
    end
  end

  def true?
    return self.to_b
  end
end