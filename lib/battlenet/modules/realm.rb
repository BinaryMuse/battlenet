class Battlenet
  module Realm
    def realm(options)
      get "/realm/status", options
    end
  end
end
