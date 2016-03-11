require 'uglifier'

module Jekyll
  module Converters
    module Minify
      def self.symbolize_keys(hash)
        return {} if hash.nil?
        hash.inject({}) do |result, (key, value)|
          new_key = case key
                    when String then key.to_sym
                    else key
                    end
          new_value = case value
                      when Hash then symbolize_keys(value)
                      else value
                      end
          result[new_key] = new_value
          result
        end
      end
    end
  end
end

module Jekyll
  module Converters
    class JSMinify < Converter
      safe true
      priority :lowest

      def initialize(config={})
        config['jsminify'] = Minify::symbolize_keys(config['jsminify'])
        @config = config.dup
      end


      def matches(ext)
        ext.downcase == '.js'
      end

      def output_ext(ext)
        '.js'
      end

      def convert(content)
        config = @config['jsminify'] || {}
        return content if config[:do_not_compress] == true
        Uglifier.new(config).compile content
      end
    end
  end
end

module Jekyll
  module Converters
    class CSMinify < CoffeeScript
      def initialize(config = {})
        config['jsminify'] = Minify::symbolize_keys(config['jsminify'])
        @config = config.dup
      end

      def matches(ext)
        ext.downcase == '.coffee'
      end

      def output_ext(ext)
        '.js'
      end

      def convert(content)
        config = @config['jsminify'] || {}

        js_content = super
        return js_content if config[:do_not_compress] == true

        Uglifier.new(config).compile(js_content)
      end
    end
  end
end
