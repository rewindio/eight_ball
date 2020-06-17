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

  describe 'satisfied?' do
    it 'should raise' do
      expect { EightBall::Conditions::Base.new.satisfied? }.to raise_error RuntimeError, 'You can never satisfy the Base condition'
    end
  end
end
