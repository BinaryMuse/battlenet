module Battlenet
  module API
    module Quest
      extend self

      @api = Battlenet::API

      def with_id(questId)
        @api.make_api_call "quest/#{questId}"
      end
    end
  end
end
