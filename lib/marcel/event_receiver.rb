require 'hutch'

module Marcel
  class EventReceiver
    include ::Hutch::Consumer

    def initialize
    end

    def process(event)
      event_dispatcher.dispatch event
    end

    def event_dispatcher
      Marcel.event_dispatcher
    end

  end
end
