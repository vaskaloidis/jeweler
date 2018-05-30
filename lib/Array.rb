class Array
  def log_errors(prefix_msg = nil)
    each do |e|
      if prefix_msg.nil?
        Rails.logger e
      else
        Rails.logger prefix_msg + ': ' + e
      end
    end
  end
  def build_errors
    each do |e|
      @errors << e
    end
  end
end