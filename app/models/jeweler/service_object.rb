module Jeweler
  class ServiceObject
    # include Virtus.model
    # attribute :outcome, Jeweler::ServiceOutcome
    attr_reader :result, :errors, :success, :failure, :success_message, :outcome

    def self.call(*args)
      new(*args).tap do |service|
        se = Jeweler::ServiceOutcome.new
        service.instance_variable_set(
            "@errors",
            []
        )
        service_call = service.call
        service.instance_variable_set(
            "@result",
            service_call
        )
        se.result = service_call
        se.errors = service.errors
        se.success = service.success
        se.success_message = service.success_message
      end
    end

    def call
      raise NotImplementedError
    end

  end
end
