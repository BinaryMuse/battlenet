module Battlenet
  module Adapter; end

  module AdapterManager
    class InvalidAdapter < Exception; end

    extend self

    @adapters = {
      :net_http => "NetHTTP",
      :typhoeus => "Typhoeus"
    }

    def adapters
      @adapters
    end

    def fetch(adapter_name)
      unless adapters.include? adapter_name
        raise InvalidAdapter.new("#{adapter_name.to_s} is not a valid adapter")
      end

      adapter_class = adapters[adapter_name]
      adapter = load_adapter adapter_name, adapter_class
    end

    def register(identifier, klass)
      @adapters[identifier] = klass
    end

    private

      def load_adapter(adapter_name, klass_name)
        begin
          klass = Battlenet::Adapter.const_get("#{klass_name}", false)
        rescue NameError
          begin
            adapter_file = "battlenet/adapter/#{adapter_name.to_s}"
            require adapter_file
            klass = Battlenet::Adapter.const_get("#{klass_name}", false)
          rescue LoadError
            raise InvalidAdapter.new("adapter #{klass_name} does not exist, and file #{adapter_file} does not exist")
          rescue NameError
            raise InvalidAdapter.new("expected #{adapter_file} to define Battlenet::Adapter::#{klass_name}")
          end
        end

        return klass.new
      end
  end
end
