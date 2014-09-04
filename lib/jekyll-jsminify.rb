require 'uglifier'

DEFAULT_UGLIFY_OPTS = {
  "jsminify" => {
    :comments => :none
  }
}

module Jekyll
  module Converters
    class JSMinify < Converter
      safe true
      priority :lowest

      def initialize(config={})
        @config = DEFAULT_UGLIFY_OPTS.merge config
      end

      def matches(ext)
        ext.downcase == ".js"
      end

      def output_ext(ext)
        ".js"
      end

      def convert(content)
        Uglifier.new(@config['jsminify']).compile content
      end
    end
  end
end

module Jekyll
  module Converters
    class CSMinify < CoffeeScript
      safe true
      priority :lowest

      def initialize(config={})
        @config = DEFAULT_UGLIFY_OPTS.merge config
      end

      def matches(ext)
        ext.downcase == ".coffee"
      end

      def output_ext(ext)
        super
      end

      def convert(content)
        Uglifier.new(@config['jsminify']).compile super
      end
    end
  end
end
