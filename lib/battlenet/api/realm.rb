module Battlenet
  module API
    module Realm
      extend self

      @api = Battlenet::API

      def status(options = {})
        data = @api.make_api_call 'realm/status', options
        data["realms"]
      end
    end
  end
end
