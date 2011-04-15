        __ )          |    |    |                     |
        __ \    _` |  __|  __|  |   _ \  __ \    _ \  __|
        |   |  (   |  |    |    |   __/  |   |   __/  |
       ____/  \__,_| \__| \__| _| \___| _|  _| \___| \__|

    A Ruby library for the Battle.net Community Platform API

Battlenet is a Ruby library that exposes Blizzard's [Community Platform API](http://us.battle.net/wow/en/forum/topic/2369881371).

Installing
==========

Battlenet is available as a Ruby gem. Install it via

    [sudo] gem install battlenet

Use
===

In general, the API is split into several sub-modules, each corresponding to an entity in Blizzard's API. For example, methods for using the Realm Status API are located in the module `Battlenet::API::Realm`. Methods on the model allow you to fetch certain information about the given entity. Arguments passed to the methods allow you to specify query string parameters. As an example, here are some sample API calls and the URL they translate into.

    Battlenet::API::Realm.status
     # => "http://us.battle.net/api/wow/realm/status"
    Battlenet::API::Realm.status :realm => "Nazjatar"
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar"
    Battlenet::API::Realm.status :realm => ["Nazjatar", "Shadowsong"]
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar&realm=Shadowsong"

Calls to the methods return an array of Hashes, and each hash contains the data for the queried resources. The attributes can be accessed via Strings or Symbols (you can set this to Strings only via `Battlenet::API.indifferent_hashes = false`).

**Note**: This is all subject to change depending on how Blizzard architects the rest of their API.

Configuration
=============

You may pass multiple options to Battlenet to change the behavior.

Indifferent Hashes
------------------

By default, the Hashes returned by the library are indifferent--you can use either Strings or Symbols to access their elements.

    realm["population"] = "low"
    realm[:population]
     # => "low"

If you wish do disable this functionality and use Strings only, you may do so using the following code:

    Battlenet::API.indifferent_hashes = false

HTTP Adapter
------------

Battlenet supports multiple adapters for fetching API data over the Internet. By default, it uses Ruby's built-in `Net::HTTP` library. If you wish to use a different adapter, specify it like this:

    Battlenet::API.http_adapter = Battlenet::Adapter::Typhoeus

The following adapters are supported (more may be added later):

* `Battlenet::Adapter::NetHTTP` - Ruby's `Net::HTTP` library
* `Battlenet::Adapter::Typhoeus` - [Typhoeus](https://github.com/dbalatero/typhoeus)

Currently Supported APIs
========================

Currently, the following APIs are supported. More will be added as Blizzard expands their API library.

 * [Realm Status API](http://us.battle.net/wow/en/forum/topic/2369741469)

Realm Status API
----------------

    api = Battlenet::API::Realm

    # Getting data for all realms
    all_realms = api.status
    # Getting data for specific realms
    realms     = api.status :realm => ["Nazjatar", "Shadowsong"]
    # Getting data for one realm
    realm      = api.status :realm => "Nazjatar"

    # Getting data about a realm
    realms.first["population"]
     # => "low"
    realms.first["queue"]
     # => false

Contributing
============

If you would like to contribute to the project, please feel free to do so. Just fork the project, commit your changes (preferably to a new branch), and then send me a pull request via GitHub.

Please do not change the contents of the `VERSION` file, or if you do, do so in a separate commit so that I can cherry-pick around it.

License
=======

Battlenet is released under the MIT license.

    Copyright (c) 2011 Brandon Tilley

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.
