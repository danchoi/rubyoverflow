require File.dirname(__FILE__) + "/spec_helper"

describe Stats do
  it "retrieves stats" do
    result = Rubyoverflow::Stats.fetch
    result.should respond_to(:items)
  end
end
