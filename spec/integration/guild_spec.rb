require 'spec_helper'

describe Battlenet::Guild do
  let(:api) { Battlenet.new }

  it "fetches guild data" do
    VCR.use_cassette('guild_rl_bl') do
      guild = api.guild 'nazjatar', 'RL BL'
      guild['level'].should == 25
    end
  end

  it "fetches additional guild data" do
    VCR.use_cassette('guild_rl_bl_members') do
      guild = api.guild 'nazjatar', 'rl bl', :fields => 'members'
      guild['members'].find { |c| c["character"]["name"] == "Cyaga" }.fetch("rank").should == 1
    end
  end
end
