module Battlenet
  module API
    module Guild
      extend self

      @api = Battlenet::API

      def profile(guildName,realm,fields = [])
        # The core dataset returned includes the guild's name, level, faction and achievement points.
        @api.make_api_call "guild/#{realm}/#{guildName.gsub(' ','%20')}", {:fields => fields.join(",")}
      end
      
      def list_possible_fields()
        {
        "members" => "A list of characters that are a member of the guild  ",
        "achievements" => "A set of data structures that describe the achievements earned by the guild."
        }
      end
      
    end
  end
end
