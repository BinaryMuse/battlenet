class Battlenet
  module Character
    def character(realm, name, *fields)
      get "/character/#{realm}/#{name}"
    end
  end
end
