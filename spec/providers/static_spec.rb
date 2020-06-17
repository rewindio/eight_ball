# frozen_string_literal: true

RSpec.describe EightBall::Providers::Static do
  describe 'initialize' do
    it 'should ensure features is an array' do
      feature = EightBall::Feature.new 'Feature'

      provider = EightBall::Providers::Static.new feature

      expect(provider.features).to contain_exactly feature
    end
  end

  describe 'features' do
    it 'should return the features provided at construction time' do
      provider1 = EightBall::Providers::Static.new []
      expect(provider1.features).to eq []

      features = [
        EightBall::Feature.new('EnabledFeature'),
        EightBall::Feature.new('DisabledFeature', nil, EightBall::Conditions::Always.new)
      ]
      provider2 = EightBall::Providers::Static.new features
      expect(provider2.features).to contain_exactly(*features)
    end
  end
end
