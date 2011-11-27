# encoding: utf-8

require 'spec_helper'

describe Battlenet::Modules::Character do
  let(:api) { Battlenet.new }

  it "fetches character data" do
    VCR.use_cassette('character_mortawa') do
      character = api.character 'nazjatar', 'mortawa'
      character['level'].should == 85
    end
  end

  it "fetches additional character data" do
    VCR.use_cassette('character_mortawa_titles') do
      character = api.character 'nazjatar', 'mortawa', :fields => 'titles'
      character['titles'].find { |t| t['selected'] == true }['name'].should == "Twilight Vanquisher %s"
    end
  end

  it "fetches characters with non-ASCII characters in their name" do
    VCR.use_cassette('character_nonstandard_name') do
      character = api.character 'nazjatar', 'Hikô'
      character['level'].should == 85
    end
  end
end
