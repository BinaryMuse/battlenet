class Battlenet
  module Guild
    def guild(realm, name, options)
      get "/guild/#{realm}/#{name}", options
    end
  end
end
