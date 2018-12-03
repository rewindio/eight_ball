# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions do
  describe 'by_name' do
    it 'should be case insensitive' do
      EightBall::Conditions.by_name('always').must_equal EightBall::Conditions::Always
      EightBall::Conditions.by_name('ALWAYS').must_equal EightBall::Conditions::Always
      EightBall::Conditions.by_name('Always').must_equal EightBall::Conditions::Always
      EightBall::Conditions.by_name('aLwAyS').must_equal EightBall::Conditions::Always
    end
  end
end
