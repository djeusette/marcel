require 'marcel/event_handler'
require 'marcel/event_receiver'
require 'marcel/event_dispatcher'
require 'marcel/logging'
require 'marcel/config'
require 'marcel/version'

module Marcel

  def self.logger
    Marcel::Logging.logger
  end

  def self.event_dispatcher
    Marcel::EventDispatcher
  end

  def self.event_receiver
    Marcel::EventReceiver
  end

  def self.register_event_handler(event_handler)
    self.event_dispatcher.register_event_handler event_handler
  end

  def self.initialize(options = {}, config = Hutch::Config)
    @options = options
    @config  = config

    @broker = ::Hutch::Broker.new(config)
    @worker = ::Hutch::Worker.new(@broker, [event_receiver])
  end

  def self.start(*routing_keys)
    unless started?
      event_receiver.consume *routing_keys
      event_dispatcher.setup_mapping

      @broker.connect(@options)
      @worker.run
    end
  end

  def self.started?
    return false unless @worker
    return false unless @broker
    return false unless @broker.connection
    @broker.connection.open?
  end

end
