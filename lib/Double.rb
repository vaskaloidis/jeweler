class Double
  def prettify
    if self.nil?
      return 0
    else
      if self.round(2) == self
        return self.round(2)
      else
        return self
      end
    end
  end

  def hours
    result = self.prettify
    if result == 1
      result = result + ' hr.'
    else
      result = result + 'hrs.'
    end
    return result
  end

  def money
    require 'action_view'
    result = self.prettify
    result = ActionView::Base.new.number_to_currency(result).to_s
    return result
  end
end