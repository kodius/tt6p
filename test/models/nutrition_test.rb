require "test_helper"

describe Nutrition do
  let(:nutrition) { Nutrition.new }

  it "must be valid" do
    value(nutrition).must_be :valid?
  end
end
