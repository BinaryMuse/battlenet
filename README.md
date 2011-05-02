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

In general, the API is split into several sub-modules, each corresponding to an entity in Blizzard's API. For example, methods for using the Realm Status API are located in the module `Battlenet::API::Realm`. Methods on the module allow you to fetch certain information about the given entity. Arguments passed to the methods allow you to specify query string parameters. As an example, here are some sample API calls and the URLs they translate into.

    Battlenet::API::Realm.status
     # => "http://us.battle.net/api/wow/realm/status"
    Battlenet::API::Realm.status :realm => "Nazjatar"
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar"
    Battlenet::API::Realm.status :realm => ["Nazjatar", "Shadowsong"]
     # => "http://us.battle.net/api/wow/realm/status?realm=Nazjatar&realm=Shadowsong"

Calls to the methods return an array of Hashes, and each hash contains the data for the queried resources.

**Note**: This is all subject to change depending on how Blizzard architects the rest of their API.

Configuration
=============

You may pass multiple options to Battlenet to change its behavior.

Region
------

By default, the region is set to `:us`, which corresponds to the US Battle.net API. You may set this to any symbol to force the library to use that region's API.

    Battlenet::API.set_option(:region, :eu)

HTTP Adapter
------------

Battlenet supports multiple adapters for fetching API data over the Internet. By default, it uses Ruby's built-in `Net::HTTP` library. If you wish to use a different adapter, specify it like this:

    Battlenet::API.set_option(:http_adapter, :typhoeus)

The following adapters are currently supported (more may be added later):

* `:net_http` - Ruby's `Net::HTTP` library
* `:typhoeus` - [Typhoeus](https://github.com/dbalatero/typhoeus)

Note that the adapter must be set before any API calls are made.


### Creating an Adapter

If you wish to, you can create your own adapters. See the [Creating an Adapter wiki page](https://github.com/BinaryMuse/battlenet/wiki/Creating-an-Adapter) for more details.

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

If you would like to contribute to the project, please feel free to do so. Just fork the project, commit your changes (preferably to a new branch), and then send me a pull request via GitHub. Be sure to add tests for your feature or fix.

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
