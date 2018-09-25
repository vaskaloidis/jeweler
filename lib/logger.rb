class Logger
  @levels = [:debug, :info, :warning, :error, :fatal]

  def error(msg)
    Rails.logger.error(msg)
    Rollbar.error(msg)
  end

  def method_missing(name, *args, &block)
    # Rails.logger.info "Logger: called #{name} with #{args.inspect} and #{block}"
    message = args.first
    if @levels.include? name
      Rails.logger.send(name, message)
      if name == 'fatal'
        Rollbar.critical(name, message)
      else
        Rollbar.send(name, message)
      end
    else
      super
    end
  end

end