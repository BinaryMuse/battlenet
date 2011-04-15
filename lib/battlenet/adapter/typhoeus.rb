require 'battlenet/adapter/abstract_adapter'
require 'typhoeus'

module Battlenet
  module Adapter
    class Typhoeus < AbstractAdapter
      def get(url)
        response = ::Typhoeus::Request.get url
        [response.code.to_i, response.body]
      end
    end
  end
end
