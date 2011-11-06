require 'uri'

class Battlenet
  module Character
    def character(realm, name, options = {})
      realm = URI.escape realm
      name = URI.escape name

      get "/character/#{realm}/#{name}", options
    end
  end
end
