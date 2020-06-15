# frozen_string_literal: true

describe EightBall do
  it 'should have a version number' do
    expect(EightBall::VERSION).not_to be_nil
  end

  describe 'logger=' do
    after do
      EightBall.logger = nil
    end

    it 'should use provided logger' do
      logger_double = double
      expect(logger_double).to receive(:warn).with('yes')

      EightBall.logger = logger_double
      EightBall.logger.warn 'yes'
    end
  end

  context 'without a provider configured' do
    describe 'features' do
      it 'should raise an error if no provider has been configured' do
        expect { EightBall.features }.to raise_error RuntimeError, 'No Provider has been configured; there can be no features. Please see "EightBall.provider="'
      end
    end
  end

  context 'with a provider configured' do
    before do
      @provider = EightBall::Providers::Static.new [
        EightBall::Feature.new('EnabledFeature'),
        EightBall::Feature.new('DisabledFeature', nil, EightBall::Conditions::Always.new)
      ]

      EightBall.provider = @provider
    end

    describe 'features' do
      it 'should return the features on the provider' do
        expect(EightBall.features).to eql @provider.features
      end
    end

    describe 'enabled?' do
      it 'should return false if feature does not exist' do
        expect(EightBall.enabled?('DoesNotExist')).to be false
      end

      it 'should return true if feature is enabled' do
        expect(EightBall.enabled?('EnabledFeature')).to be true
      end

      it 'should return false if feature is disabled' do
        expect(EightBall.enabled?('DisabledFeature')).to be false
      end
    end

    describe 'disabled?' do
      it 'should return true if feature does not exist' do
        expect(EightBall.disabled?('DoesNotExist')).to be true
      end

      it 'should return false if feature is enabled' do
        expect(EightBall.disabled?('EnabledFeature')).to be false
      end

      it 'should return true if feature is disabled' do
        expect(EightBall.disabled?('DisabledFeature')).to be true
      end
    end

    describe 'with' do
      it 'should yield if feature enabled' do
        expect { |b| EightBall.with('EnabledFeature', &b) }.to yield_control
      end

      it 'should not yield if feature disabled' do
        expect { |b| EightBall.with('DisabledFeature', &b) }.not_to yield_control
      end

      it 'should should return false if no block given' do
        expect(EightBall.with('EnabledFeature')).to be false
      end
    end
  end
end
