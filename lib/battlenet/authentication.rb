require 'time'
require 'base64'
require 'openssl'

class Battlenet
  class Authentication
    def initialize(private)
      @private = private
    end

    def sign(verb, path, time)
      string = string_to_sign(verb, path, time)
      signature = OpenSSL::HMAC.digest 'sha1', @private, string
      Base64.encode64 signature
    end

    def string_to_sign(verb, path, time)
      "#{verb.to_s.upcase}\n#{time.httpdate}\n#{path}\n"
    end
  end
end
