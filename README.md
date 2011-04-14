battlenet
=========

Battlenet is a Ruby library that exposes Blizzard's [Community Platform API](http://us.battle.net/wow/en/forum/topic/2369881371).

Installing
----------

Battlenet is available as a Ruby gem. Install it via

    [sudo] gem install battlenet

Then, using it is as simple as

    require 'battlenet'
    api = Battlenet::API

Use
---

In general, you can access information from the API by calling the API's `get` method and passing in as the first parameter the name of the resource you wish to access. You may pass a Hash as a second parameter; this Hash will be converted to query string parameters.

For example, the following API calls result in calls to the URL following them:

    Battlenet::API.get "realm/status"
     # => "http://us.battle.net/api/wow/realm/status"
    Battlenet::API.get "realm/status", :realm => "Nazjatar"
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar"
    Battlenet::API.get "realm/status", :realm => ["Nazjatar", "Shadowsong"]
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar&realm=Shadowsong"

Calls to `get` return an array of Hashes, and each hash contains the data for the queried resources. The attributes can be accessed via Strings or Symbols (you can set this to Strings only via `Battlenet::API.indifferent_hashes = false`).

Currently Supported APIs
------------------------

Currently, the following APIs are supported. More will be added as Blizzard expands the API library.

 * [Realm Status API](http://us.battle.net/wow/en/forum/topic/2369741469)

Examples: Realm Status API
--------------------------

    # Getting all realms
    all_realms = api.get "realm/status"
    # Getting specific realms
    realms     = api.get "realm/status", :realm => ["Nazjatar", "Shadowsong"]
    # Fetching one realm
    realm      = api.get "realm/status", :realm => "Nazjatar"
    # Getting data about a realm
    realms.first["population"] => "low"
    realms.first["queue"] => false
