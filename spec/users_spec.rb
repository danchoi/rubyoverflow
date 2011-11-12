require File.dirname(__FILE__) + "/spec_helper"

describe Users do
  before(:each) do
    @client = Client.new
  end

  it "retrieves sites" do
    result = @client.users.fetch
    result.should respond_to(:users)
    result.page.should == 1
  end

  it "retrieves phsr" do
    result = @client.users.fetch(:id => 53587)
    result.users.first.display_name.should == 'phsr'
  end

  it "retrieves multiple users by an array of ids" do
    result = @client.users.fetch(:id => [53587,22656])
    result.total.should == 2
  end
end
