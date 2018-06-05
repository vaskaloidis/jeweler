# frozen_string_literal: true

module Jeweler
  class ServiceOutcome
    include Virtus.model
    attribute :success, Boolean, default: false
    attribute :success_message, String
    attribute :errors, Array
    attribute :result

    def failure?
      if success
        false
      else
        true
      end
    end

    def success?
      if success
        true
      else
        false
      end
    end

  end
end