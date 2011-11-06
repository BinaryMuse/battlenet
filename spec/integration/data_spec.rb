require 'spec_helper'
require 'battlenet'

describe Battlenet::Data do
  let(:api) { Battlenet.new }

  it "fetches character races data" do
    VCR.use_cassette('character_races') do
      data = api.character_races
      data["races"].first["name"].should == "Dwarf"
    end
  end

  it "fetches character classes data" do
    VCR.use_cassette('character_classes') do
      data = api.character_classes
      data["classes"].first["name"].should == "Hunter"
    end
  end

  it "fetches guild rewards data" do
    VCR.use_cassette('guild_rewards') do
      data = api.guild_rewards
      data["rewards"].first["achievement"]["description"].should == "Craft 500 Epic items with an item level of at least 359."
    end
  end

  it "fetches guild perks data" do
    VCR.use_cassette('guild_perks') do
      data = api.guild_perks
      data["perks"].first["spell"]["name"].should == "Fast Track"
    end
  end

  it "fetches item classes data" do
    VCR.use_cassette('item_classes') do
      data = api.item_classes
      data["classes"].first["name"].should == "Consumable"
    end
  end
end
