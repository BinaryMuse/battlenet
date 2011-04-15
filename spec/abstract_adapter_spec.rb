require 'battlenet/adapter/abstract_adapter'

describe Battlenet::Adapter::AbstractAdapter do
  it "has a method 'get'" do
    subject.should respond_to :get
  end

  context "#get" do
    it "is abstract" do
      lambda {
        subject.get('fake_url')
      }.should raise_error Battlenet::Adapter::NotImplementedException
    end
  end
end
