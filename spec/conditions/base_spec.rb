# frozen_string_literal: true

RSpec.describe EightBall::Conditions::Base do
  describe 'parameter' do
    it 'should return nil' do
      expect(EightBall::Conditions::Base.new.parameter).to be_nil
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
      expect(condition.parameter).to eq 'some_case'

      condition.parameter = 'SomeCase'
      expect(condition.parameter).to eq 'some_case'
    end
  end

  describe '==' do
    it 'should return true for identical objects' do
      c1 = EightBall::Conditions::Base.new
      c2 = EightBall::Conditions::Base.new

      expect(c1 == c2).to be true
    end

    it 'should return false for objects of different types' do
      c1 = EightBall::Conditions::Always.new
      c2 = EightBall::Conditions::Never.new

      expect(c1 == c2).to be false
    end

    it 'should return false for objects that have different parameter names' do
      c1 = EightBall::Conditions::List.new parameter: 'param1'
      c2 = EightBall::Conditions::List.new parameter: 'param2'

      expect(c1 == c2).to be false
    end
  end

  describe 'satisfied?' do
    it 'should raise' do
      expect { EightBall::Conditions::Base.new.satisfied? }.to raise_error RuntimeError, 'You can never satisfy the Base condition'
    end
  end
end
