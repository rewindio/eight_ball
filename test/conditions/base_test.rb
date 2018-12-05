# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::Base do
  describe 'parameter' do
    it 'should return nil' do
      EightBall::Conditions::Base.new.parameter.must_be_nil
    end
  end

  describe 'parameter=' do
    it 'should ensure parameter is in snake case' do
      class DummyCondition < EightBall::Conditions::Base
        def parameter=(parameter)
          super parameter
        end
      end

      condition = DummyCondition.new
      condition.parameter = 'someCase'
      condition.parameter.must_equal 'some_case'

      condition.parameter = 'SomeCase'
      condition.parameter.must_equal 'some_case'
    end
  end

  describe 'satisfied?' do
    it 'should raise' do
      e = -> { EightBall::Conditions::Base.new.satisfied? }.must_raise
      e.message.must_equal 'You can never satisfy the Base condition'
    end
  end
end
