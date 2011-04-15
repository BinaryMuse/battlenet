require 'battlenet/api'

describe Battlenet::API do
  context "configuration management" do
    it "defauls to nil when getting an unset option" do
      subject.get_option(:a_fake_setting_i_made_up).should be_nil
    end

    it "returns a passed value if an option is not set" do
      subject.get_option(:a_fake_setting_i_made_up, "value").should == "value"
    end

    it "allows setting and retrieving a value" do
      subject.set_option(:a_fake_setting_i_made_up, "my_value")
      subject.get_option(:a_fake_setting_i_made_up).should == "my_value"
    end
  end

  context "default configuration" do
    it "defaults to the US region" do
      subject.get_option(:region).should == :us
    end

    it "defaults to indifferent hashes" do
      subject.get_option(:indifferent_hashes).should == true
    end

    it "defaults to the Net::HTTP library" do
      subject.get_option(:http_adapter).should == :net_http
    end
  end

  context "HTTP adapter" do
    it "retrieval is via the Adapter module" do
      adapter = subject.get_option(:http_adapter)
      Battlenet::AdapterManager.should_receive(:fetch).with(adapter)
      subject.send(:adapter)
    end

    it "caches its adapter" do
      mock_adapter = mock("adapter")
      Battlenet::AdapterManager.should_receive(:fetch).with(any_args()).and_return(mock_adapter)
      adapter = subject.send(:adapter)
      subject.set_option(:http_adapter, :fake_adapter)
      subject.send(:adapter).should == mock_adapter
    end
  end

  it "returns a base URL dependant on the region" do
    old_region = subject.get_option(:region)
    subject.set_option(:region, :eu)
    subject.send(:base_url).should == "http://eu.battle.net/api/wow"
    subject.set_option(:region, old_region)
  end

  context "#make_query_string" do
    it "produces an empty string with an empty hash" do
      str = subject.send(:make_query_string, {})
      str.should be_empty
    end

    it "starts with a question mark" do
      str = subject.send(:make_query_string, {:first => "value1", :second => "value2"})
      str.start_with?("?").should == true
    end

    it "parses a basic hash" do
      str = subject.send(:make_query_string, {:first => "value1", :second => "value2"})
      str.should == "?first=value1&second=value2"
    end

    it "parses a hash with array values" do
      str = subject.send(:make_query_string, {:first => ["value1", "value2"], :second => "value3"})
      str.should == "?first=value1&first=value2&second=value3"
    end

    it "escapes values" do
      str = subject.send(:make_query_string, {:first => ["value1", "va&lue2"], :second => "val&ue3"})
      str.should == "?first=value1&first=va%26lue2&second=val%26ue3"
    end
  end

  context "#make_api_call" do
    it "makes a get call with the correct URL" do
      subject.should_receive(:get).once.with("http://us.battle.net/api/wow/my/path").and_return([200, '{"testing": "value"}'])
      subject.send(:make_api_call, '/my/path')
    end

    it "adds a slash to the path if necessary" do
      subject.should_receive(:get).once.with("http://us.battle.net/api/wow/my/path").and_return([200, '{"testing": "value"}'])
      subject.send(:make_api_call, 'my/path')
    end

    it "converts the second parameter into a query string" do
      options = {:first => ["value1", "va&lue2"], :second => "val&ue3"}
      query_string = subject.send(:make_query_string, options)
      subject.should_receive(:get).once.with("http://us.battle.net/api/wow/my/path#{query_string}").and_return([200, '{"testing": "value"}'])
      subject.send(:make_api_call, 'my/path', options)
    end

    it "raises an exception on an error" do
      subject.adapter.should_receive(:get).and_return([404, "not found"])
      lambda {
        subject.make_api_call('my/path')
      }.should raise_error Battlenet::API::APIError, /404 (.*) not found/
    end

    it "returns the data as JSON" do
      subject.adapter.should_receive(:get).and_return([200, '{"testing": "value"}'])
      data = subject.make_api_call('my/path')
      data.should be_a Hash
      data["testing"].should == "value"
    end
  end
end
