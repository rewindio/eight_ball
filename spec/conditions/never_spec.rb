# frozen_string_literal: true

RSpec.describe EightBall::Conditions::Never do
  it 'should not require a parameter' do
    expect(EightBall::Conditions::Never.new.parameter).to be_nil
  end

  describe 'satifisfied?' do
    it 'should return false' do
      always = EightBall::Conditions::Never.new
      expect(always.satisfied?).to be false
    end
  end
end
