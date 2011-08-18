module Battlenet
  module API
    module Data
      extend self

      @api = Battlenet::API

      def character_races()
        # The character races data API provides a list of character races.
        @api.make_api_call("data/character/races")["races"] 
      end

      def character_classes()
        # The character classes data API provides a list of character classes.
        @api.make_api_call("data/character/classes")["classes"]
      end

      def guild_rewards()
        # The guild rewards data API provides a list of all guild rewards.
        @api.make_api_call("data/guild/rewards")["rewards"]
      end

      def guild_perks()
        # The guild perks data API provides a list of all guild perks.
        @api.make_api_call("data/guild/perks")["perks"]
      end

      def guild_achievements()
        @api.make_api_call("data/guild/achievements")["achievements"]
      end

      def item_classes()
        # The item classes data API provides a list of item classes.
        @api.make_api_call("data/item/classes")["classes"]
      end

      def achievements()
        @api.make_api_call("data/character/achievements")["achievements"]
      end

    end
  end
end
