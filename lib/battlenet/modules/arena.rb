class Battlenet
  module Arena
    def arena(realm, size, name, options)
      get "/arena/#{realm}/#{size}/#{name}", options
    end
  end
end
