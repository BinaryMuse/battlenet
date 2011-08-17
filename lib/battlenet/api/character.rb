module Battlenet
  module API
    module Character
      extend self

      @api = Battlenet::API

      def profile(name,realm,fields = [])
        # There are no required query string parameters when accessing this resource, 
        # although the "fields" query string parameter can optionally be passed
        # to indicate that one or more of the optional datasets is to be retrieved. 
        # Those additional fields are listed in the subsection titled "Optional Fields".
        # see: http://blizzard.github.com/api-wow-docs/#id3380312
        data = @api.make_api_call "character/#{realm}/#{name}", {:fields => fields.join(",")}
        puts data
        data["realms"]
      end
      
      def list_possible_fields()
        {
        "guild" => "A summary of the guild that the character belongs to. If the character does not belong to a guild and this field is requested, this field will not be exposed.",
        "stats" => "A map of character attributes and stats.",
        "talents" => "A list of talent structures.",
        "items" => "A list of items equipted by the character. Use of this field will also include the average item level and average item level equipped for the character.",
        "reputation" => "A list of the factions that the character has an associated reputation with.",
        "titles" => "A list of the titles obtained by the character including the currently selected title.",
        "professions" => "A list of the character's professions. It is important to note that when this information is retrieved, it will also include the known recipes of each of the listed professions.",
        "appearance" => "A map of values that describes the face, features and helm/cloak display preferences and attributes.",
        "companions" => "A list of all of the non-combat pets obtained by the character.",
        "mounts" => "A list of all of the mounts obtained by the character.",
        "pets" => "A list of all of the combat pets obtained by the character.",
        "achievements" => "A map of achievement data including completion timestamps and criteria information.",
        "progression" => "A list of raids and bosses indicating raid progression and completedness.",
        "pvp" => "A map of pvp information including arena team membership and rated battlegrounds information.",
        "quests" => "A list of quests completed by the character."
        }
      end
      
    end
  end
end
