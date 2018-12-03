# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::Never do
  it 'should not require a parameter' do
    EightBall::Conditions::Never.new.parameter.must_be_nil
  end
  
  describe 'satifisfied?' do
    it 'should return false' do
      always = EightBall::Conditions::Never.new
      always.satisfied?.must_equal false
    end
  end
end
