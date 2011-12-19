require 'httparty'
require 'battlenet/authentication'
require 'battlenet/modules/character'
require 'battlenet/modules/guild'
require 'battlenet/modules/realm'
require 'battlenet/modules/auction'
require 'battlenet/modules/item'
require 'battlenet/modules/recipe'
require 'battlenet/modules/quest'
require 'battlenet/modules/arena'
require 'battlenet/modules/data'

class Battlenet
  include HTTParty

  include Battlenet::Character
  include Battlenet::Guild
  include Battlenet::Realm
  include Battlenet::Auction
  include Battlenet::Item
  include Battlenet::Recipe
  include Battlenet::Quest
  include Battlenet::Arena
  include Battlenet::Data

  class << self
    attr_accessor :fail_silently
    attr_accessor :locale
  end

  @fail_silently = false
  @locale = nil

  def initialize(region = :us, public = nil, private = nil)
    @public = public
    @private = private

    @proto = @public && @private ? "https://" : "http://"
    @endpoint = '/api/wow'
    @domain = case region
    when :us
      'us.battle.net'
    when :eu
      'eu.battle.net'
    when :kr
      'kr.battle.net'
    when :tw
      'tw.battle.net'
    when :cn
      'battlenet.com.cn'
    else
      raise "Invalid region: #{region.to_s}"
    end

    @base_uri = "#{@proto}#{@domain}#{@endpoint}"
    self.class.base_uri @base_uri
  end

  def fullpath(path)
    "#{@endpoint}#{path}"
  end

  def get(path, params = {})
    make_request :get, path, params
  end

  def make_request(verb, path, params = {})
    options = {}
    headers = {}

    if @public && @private
      now = Time.now
      signed = sign_request verb, path, now
      headers.merge!({
        "Authorization" => "BNET #{@public}:#{signed}",
        "Date" => now.httpdate
      })
    end

    options[:headers] = headers unless headers.empty?
    options[:query]   = params unless params.empty?

    if Battlenet.locale
      options[:query] ||= {}
      options[:query].merge!({ :locale => Battlenet.locale })
    end

    response = self.class.send(verb, path, options)

    if response.code != 200 && Battlenet.fail_silently == false
      raise "Non-200 response: #{response.code}, #{response.body}"
    end
    response
  end

  def sign_request(verb, path, time)
    auth = Battlenet::Authentication.new @private
    auth.sign verb, fullpath(path), time
  end
end
