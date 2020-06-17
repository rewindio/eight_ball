# frozen_string_literal: true

RSpec.describe EightBall::Conditions::Always do
  it 'should not require any parameters' do
    expect(EightBall::Conditions::Always.new.parameter).to be_nil
  end

  describe 'satifisfied?' do
    it 'should return true' do
      expect(EightBall::Conditions::Always.new.satisfied?).to be true
    end
  end
end
