# frozen_string_literal: true

require 'test_helper'

describe EightBall do
  before do
    EightBall.provider = EightBall::Providers::Static.new [
      EightBall::Feature.new('EnabledFeature'),
      EightBall::Feature.new('DisabledFeature', nil, EightBall::Conditions::Always.new)
    ]
  end

  it 'should have a version number' do
    EightBall::VERSION.wont_be_nil
  end

  describe 'enabled?' do
    it 'should return false if feature does not exist' do
      EightBall.enabled?('DoesNotExist').must_equal false
    end

    it 'should return true if feature is enabled' do
      EightBall.enabled?('EnabledFeature').must_equal true
    end

    it 'should return false if feature is disabled' do
      EightBall.enabled?('DisabledFeature').must_equal false
    end
  end

  describe 'disabled?' do
    it 'should return true if feature does not exist' do
      EightBall.disabled?('DoesNotExist').must_equal true
    end

    it 'should return false if feature is enabled' do
      EightBall.disabled?('EnabledFeature').must_equal false
    end

    it 'should return true if feature is disabled' do
      EightBall.disabled?('DisabledFeature').must_equal true
    end
  end

  describe 'with' do
    it 'should yield if feature enabled' do
      stub = stub()
      stub.expects(:called)

      EightBall.with('EnabledFeature') do
        stub.called
      end
    end

    it 'should not yield if feature disabled' do
      EightBall.with('DoesNotExist') do
        flunk 'Should not have yielded for DoesNotExist'
      end
    end

    it 'should should return false if no block given' do
      EightBall.with('DoesNotExist').must_equal false
    end
  end

  describe 'logger=' do
    after do
      EightBall.logger = nil
    end

    it 'should use provided logger' do
      stub_logger = stub()
      stub_logger.expects(:warn).once.with 'yes'

      EightBall.logger = stub_logger
      EightBall.logger.warn 'yes'
    end
  end
end
