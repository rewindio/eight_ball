# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::Always do
  it 'should not require a parameter' do
    EightBall::Conditions::Always.new.parameter.must_be_nil
  end

  describe 'satifisfied?' do
    it 'should return true' do
      always = EightBall::Conditions::Always.new
      always.satisfied?.must_equal true
    end
  end
end
