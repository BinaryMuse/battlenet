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
      :region             => :us,
      :locale             => nil
    }
    # locales are region dependant, the default is the first locale for each region: 
    # possible_locales = {
    #   :us => ["en_US","es_MX"],
    #   :eu => ["en_GB","es_ES","fr_FR","ru_RU","de_DE"],
    #   :kr => ["ko_kr"],
    #   :tw => ["zh_TW"],
    #   :cn => ["zh_CN"] # battlenet.com.cn
    # }

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
      unless region == "cn"
        "http://#{region}.battle.net/api/wow"
      else
        # chinese battlenet uses another domain (see: http://us.battle.net/wow/en/forum/topic/2878487920#1)
        "http://www.battlenet.com.cn/api/wow"
      end
    end

    def make_api_call(path, query = {})
      query_string = (query.empty? and @config[:locale].nil?) ? '' : make_query_string(query)      
      url = base_url
      path = (path.start_with?('/') ? '' : '/')+path
      url << path
      url << query_string
      headers = {
        'User-Agent' => 'battlenet gem for Ruby'
      }
      unless @auth.nil?
        headers['Authorization'] = make_auth_string("/api/wow"+path,@auth[:privKey],@auth[:pubKey])
      end
      code, body = get(url,headers)
      raise APIError.new(code, body) unless code == 200
      JSON::parse body
    end

    def get(url, headers = {})
      adapter.get(url,headers)
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
      query_string << "locale=#{CGI.escape(@config[:locale])}&" unless @config[:locale].nil?
      query_string.chomp("&").chomp("?")
    end

    def make_auth_string(requestUrl,privKey,pubKey, verb = "GET")
      # be aware that this is untested code! 
      # I dont have a auth key pair from blizz, so I cant really test this.
      require 'digest/sha1'
      require 'HMAC-SHA1'
      require 'Base64'

      stringToSign = verb + "\n" +
          CGI.rfc1123_date(Time.now) + "\n" +
          requestUrl + "\n"

      signature = Base64.encode64(HMAC::SHA1.digest(privKey.encode("utf-8"),stringToSign.encode("utf-8")))
      "BNET" + " " + pubKey + ":" + signature
    end
    
  end
end
