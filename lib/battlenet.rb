require 'httparty'
require 'battlenet/authentication'
require 'battlenet/modules/character'

class Battlenet
  include HTTParty

  include Battlenet::Character

  class << self
    attr_accessor :fail_silently
    attr_accessor :localization
    @fail_silently = false
    @localization = nil
  end

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

  def get(path)
    make_request :get, path
  end

  def make_request(verb, path)
    options = {}
    if @public && @private
      now = Time.now
      signed = sign_request verb, path, now
      options.merge! :headers => {
        "Authorization" => "BNET #{@public}:#{signed}",
        "Date" => now.httpdate
      }
    end
    response = self.class.send(verb, path, options)

    if response.code != 200 && Battlenet.fail_silently == false
      raise "Non-200 response: #{response.code}, #{response.body}"
    end
    response
  end

  def sign_request(verb, path, time)
    auth = Battlenet::Authentication.new @public, @private
    auth.sign verb, fullpath(path), time
  end
end
