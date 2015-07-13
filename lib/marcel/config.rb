require 'hutch'

module Marcel

  module Config
    require 'yaml'

    class UnknownAttributeError < StandardError; end

    def self.initialize(params={})
      @config = ::Hutch::Config.merge(params)
    end

    def self.get(attr)
      check_attr(attr)
      user_config[attr]
    end

    def self.set(attr, value)
      check_attr(attr)
      user_config[attr] = value
    end

    class << self
      alias_method :[],  :get
      alias_method :[]=, :set
    end

    def self.check_attr(attr)
      unless user_config.key?(attr)
        raise UnknownAttributeError, "#{attr} is not a valid config attribute"
      end
    end

    def self.user_config
      initialize unless @config
      @config
    end

    def self.to_hash
      self.user_config
    end

    def self.load_from_file(file)
      YAML.load(ERB.new(File.read(file)).result).each do |attr, value|
        Hutch::Config.send("#{attr}=", value)
      end
    end

    def self.method_missing(method, *args, &block)
      attr = method.to_s.sub(/=$/, '').to_sym
      return super unless user_config.key?(attr)

      if method =~ /=$/
        set(attr, args.first)
      else
        get(attr)
      end
    end

  end
end
