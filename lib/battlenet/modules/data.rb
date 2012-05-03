class Battlenet
  module Modules
    module Data
      def battlegroups(options = {})
        # URL currently requires a trailing '/'
        get "/data/battlegroups/", options
      end

      def character_races(options = {})
        get "/data/character/races", options
      end

      def character_classes(options = {})
        get "/data/character/classes", options
      end

      def guild_rewards(options = {})
        get "/data/guild/rewards", options
      end

      def guild_perks(options = {})
        get "/data/guild/perks", options
      end

      def item_classes(options = {})
        get "/data/item/classes", options
      end

      def character_achievements(options = {})
        get "/data/character/achievements", options
      end

      def guild_achievements(options = {})
        get "/data/guild/achievements", options
      end
    end
  end
end
