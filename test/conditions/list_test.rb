# frozen_string_literal: true

require 'test_helper'

describe EightBall::Conditions::List do
  describe 'initialize' do
    it 'should ensure values is an array' do
      EightBall::Conditions::List.new(values: 1).values.must_equal [1]
      EightBall::Conditions::List.new(values: nil).values.must_equal []
      EightBall::Conditions::List.new(nil).values.must_equal []
      EightBall::Conditions::List.new.values.must_equal []
      EightBall::Conditions::List.new(values: 'a').values.must_equal ['a']
      EightBall::Conditions::List.new(values: []).values.must_equal []
    end

    it 'should set parameter' do
      EightBall::Conditions::List.new(parameter: 'a').parameter.must_equal 'a'
    end
  end

  describe 'satifisfied?' do
    it 'should return true if value accepted' do
      list1 = EightBall::Conditions::List.new values: [1, 2, 3]
      list1.satisfied?(1).must_equal true

      list2 = EightBall::Conditions::List.new values: %w[John Jim]
      list2.satisfied?('John').must_equal true
    end

    it 'should return false if value not accepted' do
      list1 = EightBall::Conditions::List.new values: [1, 2, 3]
      list1.satisfied?(4).must_equal false

      list2 = EightBall::Conditions::List.new values: %w[John Jim]
      list2.satisfied?('Jeremy').must_equal false
    end
  end
end
