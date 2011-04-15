require 'battlenet/adapter/abstract_adapter'
require 'net/http'

module Battlenet
  module Adapter
    class NetHTTP < AbstractAdapter
      def get(url)
        uri      = URI.parse url
        response = Net::HTTP.get_response uri
        [response.code.to_i, response.body]
      end
    end
  end
end
