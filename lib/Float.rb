class Float
  def prettify
    if self.nil?
      return 0
    else
      if self.to_i == self
        return self.round(0)
      else
        return self
      end
    end
  end

  def hours
    result = self.prettify
    if result == 1
      result = result.to_s + ' hr.'
    else
      result = result.to_s + ' hrs.'
    end
    return result
  end

  def sprint_rate
    result = self.prettify.to_s
    result = '$' + result + ' /hr'
    return result
  end

  def money
    require 'action_view'
    result = self.prettify
    result = ActionView::Base.new.number_to_currency(result).to_s
    return result
  end
end