module Marcel
  module Logging

    def self.setup_logger
      ::Hutch::Logging.logger
    end

    def self.logger
      @logger || setup_logger
    end

    def self.logger=(logger)
      @logger = logger
    end

    def logger
      Marcel::Logging.logger
    end
  end
end
