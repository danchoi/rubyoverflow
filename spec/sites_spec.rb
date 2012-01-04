require File.dirname(__FILE__) + "/spec_helper"

describe Sites do
  before(:each) do
    @client = Client.new
  end

  describe ".fetch" do
    it "retrieves sites" do
      result = Rubyoverflow::Sites.fetch
      result.should respond_to(:items)
    end

    it "retrieves second page of sites" do
      result = Rubyoverflow::Sites.fetch :page => 2
      result.should respond_to(:items)
    end
  end
end
