# frozen_string_literal: true

require 'test_helper'

describe EightBall::Providers::Static do
  describe 'features' do
    it 'should return the feature array provided at construction time' do
      provider1 = EightBall::Providers::Static.new []
      provider1.features.must_equal []

      features = [
        EightBall::Feature.new('EnabledFeature'),
        EightBall::Feature.new('DisabledFeature', nil, EightBall::Conditions::Always.new)
      ]
      provider2 = EightBall::Providers::Static.new features
      provider2.features.must_equal features
    end
  end
end
