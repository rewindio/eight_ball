# frozen_string_literal: true

describe EightBall::Providers::RefreshPolicies::Interval do
  describe 'refresh' do
    it 'should yield on first call' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      expect { |b| policy.refresh(&b) }.to yield_control
    end

    it 'should yield if stale' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      d1 = DateTime.now
      d2 = d1 + Rational(61, 86_400)
      allow(DateTime).to receive(:now).and_return d1, d2

      # Yields both times (first call ever, and on expired interval)
      expect { |b| policy.refresh(&b) }.to yield_control
      expect { |b| policy.refresh(&b) }.to yield_control
    end

    it 'should not yield if not stale' do
      policy = EightBall::Providers::RefreshPolicies::Interval.new

      d1 = DateTime.now
      d2 = d1 + Rational(10, 86_400)
      allow(DateTime).to receive(:now).and_return d1, d2

      # Yields only first time, not on a non-expired interval
      expect { |b| policy.refresh(&b) }.to yield_control
      expect { |b| policy.refresh(&b) }.not_to yield_control
    end
  end
end
