require 'battlenet/adapter/abstract_adapter'
require 'typhoeus'

module Battlenet
  module Adapter
    class Typhoeus < AbstractAdapter
      def get(url, headers, dry = false)
        url = url.gsub("http://","https://") unless headers["Authorization"].nil?
        response = ::Typhoeus::Request.get(url, {:headers => headers, :user_agent => headers["User-Agent"]})
        [response.code.to_i, response.body]
      end
    end
  end
end
