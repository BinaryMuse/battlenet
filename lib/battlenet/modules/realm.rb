class Battlenet
  module Modules
    module Realm
      def realm(options = {})
        get "/realm/status", options
      end
    end
  end
end
