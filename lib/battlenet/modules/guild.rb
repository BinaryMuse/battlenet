require 'uri'

class Battlenet
  module Modules
    module Guild
      def guild(realm, name, options = {})
        realm = URI.escape realm
        name = URI.escape name

        get "/guild/#{realm}/#{name}", options
      end
    end
  end
end
