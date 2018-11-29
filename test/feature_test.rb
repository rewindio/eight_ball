# frozen_string_literal: true

require 'test_helper'

describe EightBall::Feature do
  describe 'enabled?' do
    it 'should return true if no conditions' do
      feature = EightBall::Feature.new 'NoConditions'
      feature.enabled?.must_equal true
    end

    it 'should return true if one of the enabledFor conditions is satisfied' do
      satisfied = EightBall::Conditions::Always.new
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [satisfied, unsatisfied]
      feature.enabled?.must_equal true
    end

    it 'should return true if all of the enabledFor conditions are satisfied' do
      satisfied1 = EightBall::Conditions::Always.new
      satisfied2 = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', [satisfied1, satisfied2]
      feature.enabled?.must_equal true
    end

    it 'should return false if none of the enabledFor conditions are satisfied' do
      unsatisfied1 = EightBall::Conditions::Never.new
      unsatisfied2 = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [unsatisfied1, unsatisfied2]
      feature.enabled?.must_equal false
    end

    it 'should return true if enabledFor satisfied and disabledFor not satisfied' do
      satisfied = EightBall::Conditions::Always.new
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [satisfied], [unsatisfied]
      feature.enabled?.must_equal true
    end

    it 'should return false if no enabledFor provided and disabledFor is satisfied' do
      satisfied = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', nil, [satisfied]
      feature.enabled?.must_equal false
    end

    it 'should return true if no enabledFor provided and disabledFor is not satisfied' do
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', nil, [unsatisfied]
      feature.enabled?.must_equal true
    end

    it 'should return false if enabledFor is satisfied and disabledFor is satisfied' do
      satisfied1 = EightBall::Conditions::Always.new
      satisfied2 = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', [satisfied1], [satisfied2]
      feature.enabled?.must_equal false
    end

    it 'should raise an Exception if a parameter is missing' do
      condition = EightBall::Conditions::List.new parameter: 'param1', values: [1, 2]
      feature = EightBall::Feature.new 'Feature', condition

      e = -> { feature.enabled? }.must_raise Exception
      e.message.must_equal 'Missing parameter param1'
    end
  end
end
