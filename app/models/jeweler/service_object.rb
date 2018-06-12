module Jeweler
  class ServiceObject
    attr_reader :result, :errors, :fatals, :success, :success_message, :outcome

    def self.call(*args)
      new(*args).tap do |service|
        service.instance_variable_set(
            '@errors',
            []
        )
        service.instance_variable_set(
            '@fatals',
            []
        )
        begin
          tapped_result = service.call
        rescue StandardError => e
          Rails.logger.fatal('ServiceObject Exception: ' + e.message)
          Rails.logger.debug('ServiceObject Exception Tap Inspected: ' + service.inspect)
          # Rails.logger.debug('ServiceObject Exception Result: ' + tapped_result.attributes.inspect)
          # TODO: Log to Rollbar
        end

        service.instance_variable_set(
            '@result',
            tapped_result
        )
        tapped_errors = service.instance_variable_get('@errors')
        tapped_fatals = service.instance_variable_get('@fatals')

        tapped_errors.each do |error|
          Rails.logger.warn error
        end

        tapped_fatals.each do |fatal|
          Rails.logger.error fatal
          tapped_errors << fatal
        end

        service.instance_variable_set(
            '@errors',
            tapped_errors
        )

      end
    end

    def call
      raise NotImplementedError
    end

  end
end
