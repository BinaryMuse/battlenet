require 'battlenet/adapter/abstract_adapter'
require 'net/http'

module Battlenet
  module Adapter
    class NetHTTP < AbstractAdapter
      def get(url,headers={})
        uri = URI.parse(url)
        req = Net::HTTP.new(uri.host)
        req.get(uri.request_uri, headers).body
        response = req.get(uri.request_uri,headers)
        [response.code.to_i, response.body]
      end
    end
  end
end
