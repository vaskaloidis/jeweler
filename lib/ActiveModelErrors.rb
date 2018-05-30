# frozen_string_literal: true
module ActiveModel

  class Errors
    def build_errors
      full_messages.each do |e|
        @errors << e
      end
    end
  end

end