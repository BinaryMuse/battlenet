require 'battlenet/adapter_manager'
require 'cgi'
require 'json'

module Battlenet
  module API
    class APIError < Exception
      attr_reader :code, :body
      def initialize(code, body)
        @code = code
        @body = body
      end

      def to_s
        "Status: #{code} Body: #{body}"
      end
    end

    extend self

    attr_accessor :auth

    @auth = nil

    @config = {
      :indifferent_hashes => true,
      :http_adapter       => :net_http,
      :region             => :us
    }

    def set_option(setting, value)
      @config[setting] = value
    end

    def get_option(setting, default = nil)
      @config[setting] || default
    end

    def adapter
      @adapter ||= Battlenet::AdapterManager.fetch get_option(:http_adapter)
    end

    def base_url
      region = get_option(:region, :us).to_s
      "http://#{region}.battle.net/api/wow"
    end

    def make_api_call(path, query = {})
      query_string = query.empty? ? '' : make_query_string(query)
      url = base_url
      url << (path.start_with?('/') ? '' : '/')
      url << path
      url << query_string
      code, body = get url
      raise APIError.new(code, body) unless code == 200
      JSON::parse body
    end

    def get(url)
      headers = {
        'User-Agent' => 'battlenet gem for Ruby'
      }
      puts "Debug: url : #{url}"
      unless @auth.nil?
        
      else
        adapter.get(url,headers)
      end
    end

    def make_query_string(query)
      query_string = "?"
      query.each do |key, value|
        case value
        when String
          query_string << "#{key}=#{CGI.escape value}&"
        when Array
          value.each { |v| query_string << "#{key}=#{CGI.escape v}&" }
        end
      end

      query_string.chomp("&").chomp("?")
    end
  end
end
