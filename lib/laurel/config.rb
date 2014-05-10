module Laurel
  class Config
    include Singleton
    attr_accessor :config

    def load
      if @config.nil?
        @config = Hashie::Mash.new(YAML.load_file('./config/laurel.yml'))
      end

      @config
    end

    class << self
      def method_missing(item_name, *args)
        Laurel::Config.instance.load()

        Laurel::Config.instance.config.fetch(item_name)
      end
    end
  end
end
