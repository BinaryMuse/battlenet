require 'battlenet/adapter/net_http'

describe Battlenet::Adapter::NetHTTP do
  context "basic gets" do
    it "uses SSL when authorization data is send" do
      headers = {"Authorization" => "some string that doesnt matter"}
      dryrequest = subject.send(:get, 'http://us.battle.net/api/wow/some/path', headers, true)
      dryrequest.use_ssl? == true and
    end
  end
end