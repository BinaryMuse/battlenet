require 'battlenet/adapter/abstract_adapter'
require 'net/http'

module Battlenet
  module Adapter
    class NetHTTP < AbstractAdapter
      def get(url,headers={}, dry = false)
        uri = URI.parse(url)
        if headers["Authorization"].nil?
          req = Net::HTTP.new(uri.host,80)
        else
          req = Net::HTTP.new(uri.host,443)
          req.use_ssl=true
        end
        if dry
          req
        else
          response = req.get(uri.request_uri,headers)
          [response.code.to_i, response.body]
        end
      end
    end
  end
end
