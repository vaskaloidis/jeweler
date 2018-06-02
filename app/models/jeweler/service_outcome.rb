# frozen_string_literal: true

module Jeweler::Service
  class Status
    include Virtus.model

    attribute :success, Boolean
    attribute :failure, Boolean
    attribute :message, String
  end
end