require "rails_helper"

RSpec.describe TDEECalculator do
  it "calculates tdee for man" do
    result = TDEECalculator.bmr(100, 183, 41, 'man')
    assert_equal(1762, result)
  end

  it "calculates tdee for woman" do
    result = TDEECalculator.bmr(60, 165, 37, 'woman')
    assert_equal(1462, result)
  end

end
