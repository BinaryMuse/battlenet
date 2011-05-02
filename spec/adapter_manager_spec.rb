require 'battlenet/adapter_manager'

describe Battlenet::AdapterManager do
  it "has a list of adapters" do
    subject.adapters.should be_a Hash
  end

  context "#fetch" do
    it "raises an exception if an invalid adapter is passed" do
      lambda {
        subject.fetch(:some_fake_adapter)
      }.should raise_error Battlenet::AdapterManager::InvalidAdapter
    end

    it "requires a library file based on the adapter chosen if the class doesn't exist" do
      subject.should_receive(:require).once.with('battlenet/adapter/net_http')
      begin
        subject.fetch(:net_http)
      rescue Battlenet::AdapterManager::InvalidAdapter
        # expected
      end
    end

    it "raises an error if the adapter class doesn't exist and the library can't be loaded" do
      old_adapters = subject.adapters
      subject.instance_variable_set(:@adapters, {:adapter => "SuperAdapter"})

      lambda {
        subject.fetch(:adapter)
      }.should raise_error Battlenet::AdapterManager::InvalidAdapter, /does not exist/

      subject.instance_variable_set(:@adapters, old_adapters)
    end

    it "raises an error if the adapter library is loaded but doesn't define the adapter class" do
      subject.should_receive(:require).once.with('battlenet/adapter/net_http').and_return(nil)
      lambda {
        subject.fetch(:net_http)
      }.should raise_error Battlenet::AdapterManager::InvalidAdapter, /expected (.*) to define/
    end

    it "returns an instance of the adapter" do
      adapter = subject.fetch(:net_http)
      adapter.should be_a Battlenet::Adapter::NetHTTP
    end
  end

  context "#register" do
    it "registers an adapter" do
      lambda do
        subject.register(:adapter_identifier, 'AdapterClass')
      end.should change(subject.adapters, :count).by(1)
    end
  end
end
