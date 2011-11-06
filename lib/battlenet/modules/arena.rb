require 'uri'

class Battlenet
  module Arena
    def arena(realm, size, name, options = {})
      realm = URI.escape realm
      size = URI.escape size
      name = URI.escape name

      get "/arena/#{realm}/#{size}/#{name}", options
    end
  end
end
