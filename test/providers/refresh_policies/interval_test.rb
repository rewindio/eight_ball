# frozen_string_literal: true

require 'test_helper'

describe EightBall::Providers::RefreshPolicies::Interval do
  describe 'refresh' do
    it 'should yield on first call' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      call_me = stub
      call_me.stubs(:call).once

      policy.refresh do
        call_me.call
      end
    end

    it 'should yield if stale' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      d1 = DateTime.now
      d2 = d1 + Rational(60, 86_400)
      DateTime.stubs(:now).returns d1, d2

      policy.refresh {}

      call_me = stub
      call_me.stubs(:call).once

      policy.refresh do
        call_me.call
      end
    end

    it 'should not yield if not stale' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      d1 = DateTime.now
      d2 = d1 + Rational(10, 86_400)
      DateTime.stubs(:now).returns d1, d2

      policy.refresh {}

      policy.refresh do
        flunk 'Should not have yielded'
      end
    end
  end
end
