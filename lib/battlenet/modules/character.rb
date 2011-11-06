class Battlenet
  module Character
    def character(realm, name, options)
      get "/character/#{realm}/#{name}", options
    end
  end
end
