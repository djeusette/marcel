module Marcel
  module EventHandler

    def self.included(base)
      base.extend(ClassMethods)
      Marcel.register_event_handler(base)
    end

    module ClassMethods

      def logger
        Marcel::Logging.logger
      end

      def handlers
        @handlers ||= {}
      end

      # TODO: handle multiple handlers for same event name
      def on_event(event_name, &block)
        logger.info "Handler defined for event '#{event_name}'"
        self.handlers[event_name] = block
      end

      def handle(event)
        block = self.handlers[event[:name]]
        block.call(event)
      end
    end

  end
end
