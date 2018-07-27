require "test_helper"

describe Plan do
  let(:plan) { Plan.new }

  it "must be valid" do
    value(plan).must_be :valid?
  end
end
