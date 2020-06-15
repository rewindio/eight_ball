# frozen_string_literal: true

RSpec.describe EightBall::Conditions::Range do
  describe 'initialize' do
    it 'should set parameter' do
      expect(EightBall::Conditions::Range.new(parameter: 'a', min: 1, max: 3).parameter).to eq 'a'
    end

    it 'should raise if min is missing' do
      expect { EightBall::Conditions::Range.new(max: 3) }.to raise_error ArgumentError, 'Missing value for min'

      expect { EightBall::Conditions::Range.new(parameter: 'a', max: 3) }.to raise_error ArgumentError, 'Missing value for min'
    end

    it 'should raise if max is missing' do
      expect { EightBall::Conditions::Range.new(min: 3) }.to raise_error ArgumentError, 'Missing value for max'
      expect { EightBall::Conditions::Range.new(parameter: 'a', min: 3) }.to raise_error ArgumentError, 'Missing value for max'
    end

    it 'should raise if max is less than min' do
      expect { EightBall::Conditions::Range.new(min: 3, max: 1) }.to raise_error ArgumentError, 'Max must be greater or equal to min'
      expect { EightBall::Conditions::Range.new(min: 'c', max: 'a') }.to raise_error ArgumentError, 'Max must be greater or equal to min'
    end
  end

  describe 'satifisfied?' do
    it 'should return true if value within range' do
      range1 = EightBall::Conditions::Range.new min: 1, max: 3
      expect(range1.satisfied?(2)).to be true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      expect(range2.satisfied?('b')).to be true
    end

    it 'should return true if value equal to min' do
      range = EightBall::Conditions::Range.new min: 1, max: 3
      expect(range.satisfied?(1)).to be true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      expect(range2.satisfied?('a')).to be true
    end

    it 'should return true if value equal to max' do
      range = EightBall::Conditions::Range.new min: 1, max: 3
      expect(range.satisfied?(3)).to be true

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      expect(range2.satisfied?('c')).to be true
    end

    it 'should return false if value outside range' do
      range1 = EightBall::Conditions::Range.new min: 1, max: 3
      expect(range1.satisfied?(4)).to be false

      range2 = EightBall::Conditions::Range.new min: 'a', max: 'c'
      expect(range2.satisfied?('d')).to be false
    end
  end
end
