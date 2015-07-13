require "marcel/logging"

module Marcel
  class EventDispatcher
    extend Logging

    def self.event_mapping
      @event_mapping ||= {}
    end

    def self.event_handlers
      @event_handlers ||= []
    end

    def self.register_event_handler(event_handler)
      self.event_handlers << event_handler
    end

    def self.dispatch(event)
      event_name     = event[:name]
      event_handlers = event_mapping[event_name] || []

      if event_handlers.empty?
        logger.warn "No handlers for event '#{event_name}'"
      else
        event_handlers.each do |event_handler|
          event_handler.handle(event)
        end
      end
    end

    def self.setup_mapping
      self.event_handlers.each do |event_handler|
        event_handler.handlers.each_key do |event_name|
          event_mapping[event_name] ||= []
          event_mapping[event_name] << event_handler
        end
      end
    end

  end
end
