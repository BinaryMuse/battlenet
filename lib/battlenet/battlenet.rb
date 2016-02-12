require 'httparty'
require 'battlenet/authentication'
require 'battlenet/exceptions/api_exception'
require 'battlenet/modules/character'
require 'battlenet/modules/guild'
require 'battlenet/modules/realm'
require 'battlenet/modules/auction'
require 'battlenet/modules/item'
require 'battlenet/modules/achievement'
require 'battlenet/modules/recipe'
require 'battlenet/modules/quest'
require 'battlenet/modules/arena'
require 'battlenet/modules/pvp'
require 'battlenet/modules/data'

# Battlenet exposes the Blizzard Battle.net Community Platform API via an
# easy-to-use interface.
#
# The main API class includes several Modules that define methods for collecting
# specific API data. See the documentation for `Battlenet::Modules` for a list of
# these modules.
#
# Specific details about the information returned from the API can be found at Blizzard's
# [official Community Platform API documentation](https://blizzard.github.com/api-wow-docs/).
#
# @example Return basic information about a character named Cyaga from the US realm Nazjatar
#
#   api  = Battlenet.new :us
#   char = api.character 'Nazjatar', 'Cyaga'
#   char['level']
#   # => 85
#
# @example Return additional information about a character
#
#   api  = Battlenet.new :us
#   char = api.character 'Nazjatar', 'Cyaga', :fields => 'titles'
#   selected_title = char['titles'].find { |t| t['selected'] == true }
#   selected_title['name']
#   # => "%s, Guardian of Cenarius"
#
# @see Battlenet::Modules
#
# @author Brandon Tilley <brandon@brandontilley.com>
class Battlenet

  # `Battlenet::Modules` is a namespace for modules that define methods that
  # retrieve data from the Community Platform API. Methods for retrieving information
  # about related resources are grouped in the same sub-Module. See documentation for
  # the individual Modules for more information about the methods contained within.
  module Modules; end

  include HTTParty

  include Battlenet::Modules::Character
  include Battlenet::Modules::Guild
  include Battlenet::Modules::Realm
  include Battlenet::Modules::Auction
  include Battlenet::Modules::Item
  include Battlenet::Modules::Achievement
  include Battlenet::Modules::Recipe
  include Battlenet::Modules::Quest
  include Battlenet::Modules::Arena
  include Battlenet::Modules::Pvp
  include Battlenet::Modules::Data

  class << self
    # Whether or not to raise exceptions on error responses from the API endpoint.
    # A value of `false` causes exceptions to be raised. Defaults to `false`.
    #
    # @return [boolean]
    attr_accessor :fail_silently

    # The locale to use for API calls. Defaults to `nil`, which makes requests with
    # no `locale` parameter set.
    #
    # @return [String|nil]
    attr_accessor :locale
  end

  @fail_silently = false
  @locale = nil

  # Creates a new instance of the Battlenet API.
  #
  # @param region [Symbol] the region to perform API calls against.
  def initialize(region = :us, apikey = nil)
    @apikey = apikey
    @proto = "https://"
    @endpoint = '/wow'
    @domain = case region
    when :us
      'us.api.battle.net'
    when :eu
      'eu.api.battle.net'
    when :kr
      'kr.api.battle.net'
    when :tw
      'tw.api.battle.net'
    when :cn
      'api.battlenet.com.cn'
    when :sea
      'sea.api.battle.net'
    else
      raise "Invalid region: #{region.to_s}"
    end

    @base_uri = "#{@proto}#{@domain}#{@endpoint}"
    self.class.base_uri @base_uri
  end

  # Signs and performs an HTTP GET request. The request is only signed if a public and private
  # key were provided during object instantiation.
  #
  # @param path (see #make_request)
  # @param params (see #make_request)
  # @return (see #make_request)
  # @raise (see #make_request)
  # @see (see #make_request)
  def get(path, params = {})
    make_request :get, path, params
  end

  private

    # Returns the full URI for the given path based on the API endpoint set (varies by region).
    #
    # @return [String] the full URI for the path
    def fullpath(path)
      "#{@endpoint}#{path}"
    end

    # Signs and performs an HTTP request. The request is only signed if a public and private
    # key were provided during object instantiation.
    #
    # @param verb [Symbol] the HTTP verb to perform
    # @param path [String] the path to GET
    # @param params [Hash] options to be turned into query string parameters
    # @return [Object] the response object from HTTParty
    # @raise Battlenet::ApiException if the response has a 4xx or 5xx response and `Battlenet.fail_silently` is `false`
    # @see #process_response
    # @see http://rubydoc.info/github/jnunemaker/httparty/master/HTTParty/Response
    # @private
    def make_request(verb, path, params = {})
      options = {}
      headers = {}

      if @apikey
        params.merge!({"apikey" => @apikey})
      end

      options[:headers] = headers unless headers.empty?
      options[:query]   = params unless params.empty?

      if Battlenet.locale
        options[:query] ||= {}
        options[:query].merge!({ :locale => Battlenet.locale })
      end

      response = self.class.send(verb, path, options)
      process_response response
    end

    def process_response(response)
      if response.code.to_s =~ /^(4|5)/ && Battlenet.fail_silently == false
        raise Battlenet::ApiException.new(response)
      end
      response
    end
end
