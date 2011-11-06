class Battlenet
  module Data
    def character_races(options)
      get "/data/character/races", options
    end

    def character_classes(options)
      get "/data/character/classes", options
    end

    def guild_rewards(options)
      get "/data/guild/rewards", options
    end

    def guild_perks(options)
      get "/data/guild/perks", options
    end

    def item_classes(options)
      get "/data/item/classes", options
    end
  end
end
