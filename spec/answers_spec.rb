require File.dirname(__FILE__) + "/spec_helper"

describe Answers do
  it "retrieves answers" do
    result = Rubyoverflow::Answers.fetch
    result.should respond_to(:items)
  end
end
