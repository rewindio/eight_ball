# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::Range do
  describe 'initialize' do
    it 'should ensure max is greater than min' do
      EightBall::Conditions::Range.new(min: 3, max: 1).max.must_equal 3
      EightBall::Conditions::Range.new(min: 'c', max: 'a').max.must_equal 'c'
    end

    it 'should set parameter' do
      EightBall::Conditions::Range.new(parameter: 'a', min: 1, max: 3).parameter.must_equal 'a'
    end

    it 'should raise Exception if min is missing' do
      e1 = -> { EightBall::Conditions::Range.new(max: 3) }.must_raise Exception
      e1.message.must_equal 'Missing value for min'

      e2 = -> { EightBall::Conditions::Range.new(parameter: 'a', max: 3) }.must_raise Exception
      e2.message.must_equal 'Missing value for min'
    end

    it 'should raise Exception if max is missing' do
      e1 = -> { EightBall::Conditions::Range.new(min: 3)}.must_raise Exception
      e1.message.must_equal 'Missing value for max'
      

      e2 = -> { EightBall::Conditions::Range.new(parameter: 'a', min: 3) }.must_raise Exception
      e2.message.must_equal 'Missing value for max'
    end
  end

  describe 'satifisfied?' do
    it 'should return true if value within range' do
      range1 = EightBall::Conditions::Range.new min: 1, max: 3
      range1.satisfied?(2).must_equal true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      range2.satisfied?('b').must_equal true
    end

    it 'should return true if value equal to min' do
      range = EightBall::Conditions::Range.new min: 1, max: 3
      range.satisfied?(1).must_equal true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      range2.satisfied?('a').must_equal true
    end

    it 'should return true if value equal to max' do
      range = EightBall::Conditions::Range.new min: 1, max: 3
      range.satisfied?(3).must_equal true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      range2.satisfied?('c').must_equal true
    end

    it 'should return false if value outside range' do
      range1 = EightBall::Conditions::Range.new min: 1, max: 3
      range1.satisfied?(4).must_equal false

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      range2.satisfied?('d').must_equal false
    end
  end
end
