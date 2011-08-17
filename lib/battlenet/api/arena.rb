module Battlenet
  module API
    module Arena
      extend self

      @api = Battlenet::API

      def team(teamName,teamSize,realm)
        raise APIError.new(42, "Teamsize not valid! Possible Teamsizes: #{possible_team_sizes}") unless possible_team_sizes.include?(teamSize)
        @api.make_api_call "arena/#{realm}/#{teamSize}/#{teamName.gsub(' ','%20')}"
      end
      
      def possible_team_sizes()
        ["2v2","3v3","5v5"]
      end
    end
  end
end
