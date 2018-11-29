# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::Base do
  describe 'parameter' do
    it 'should return nil' do
      EightBall::Conditions::Base.new.parameter.must_be_nil
    end
  end

  describe 'satisfied?' do
    it 'should raise an Exception' do
      e = -> { EightBall::Conditions::Base.new.satisfied? }.must_raise Exception
      e.message.must_equal 'You can never satisfy the Base condition'
    end
  end
end
