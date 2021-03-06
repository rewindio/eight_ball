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
        expect { EightBall.features }.to raise_error EightBall::ConfigurationError, 'No Provider has been configured; there can be no features. Please see "EightBall.provider="'
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

    describe 'marshall' do
      it 'uses the given features' do
        marshaller_double = double
        features_double = double

        expect(marshaller_double).to receive(:marshall).with features_double

        EightBall.marshall(marshaller_double, features_double)
      end

      it 'falls back to the features from the Provider if none are passed in' do
        marshaller_double = double

        expect(marshaller_double).to receive(:marshall).with EightBall.features

        EightBall.marshall(marshaller_double)
      end

      it 'uses the given Marshaller' do
        marshaller_double = double

        expect(marshaller_double).to receive(:marshall)

        EightBall.marshall(marshaller_double)
      end

      it 'falls back to the Marshaller exposed by the Provider if none is passed in' do
        # Just hacks so I can swap out the Provider in this test only
        original_provider = @provider

        class FakeProvider
          attr_reader :marshaller
          attr_reader :features
          def initialize(marshaller)
            @marshaller = marshaller
            @features = []
          end
        end

        marshaller_double = double
        EightBall.provider = FakeProvider.new marshaller_double

        expect(marshaller_double).to receive(:marshall)

        EightBall.marshall

        # Set it back.
        @provider = original_provider
      end

      it 'falls back to a JSON Marshaller if all else fails' do
        expect_any_instance_of(EightBall::Marshallers::Json).to receive(:marshall)
        EightBall.marshall
      end
    end
  end
end
