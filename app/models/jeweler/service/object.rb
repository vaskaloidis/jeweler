module Jeweler::Service
  class Object < Patterns::Service
    include Virtus.model

    attribute :status, Jeweler::Service::Status

    def call
      raise NotImplementedError
    end

  end
end