# encoding: utf-8

require 'spec_helper'
require 'battlenet'

describe Battlenet do
  let(:api) { Battlenet.new }

  before(:each) do
    Battlenet.locale = "es_ES"
  end

  after(:each) do
    Battlenet.locale = nil
  end

  it "localizes data" do
    VCR.use_cassette('character_mortawa_es') do
      character = api.character 'nazjatar', 'mortawa', :fields => 'talents'
      character["talents"].first["glyphs"]["prime"].first["name"].should == "Glifo de Golpe con runa"
    end
  end
end
