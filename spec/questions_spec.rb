require File.dirname(__FILE__) + "/spec_helper"

describe Questions do
  it "retrieves questions" do
    result = Rubyoverflow::Questions.fetch
    result.should respond_to(:items)
  end
end
