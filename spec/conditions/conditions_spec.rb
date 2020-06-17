# frozen_string_literal: true

RSpec.describe EightBall::Conditions do
  describe 'by_name' do
    it 'should be case insensitive' do
      expect(EightBall::Conditions.by_name('always')).to eq EightBall::Conditions::Always
      expect(EightBall::Conditions.by_name('ALWAYS')).to eq EightBall::Conditions::Always
      expect(EightBall::Conditions.by_name('Always')).to eq EightBall::Conditions::Always
      expect(EightBall::Conditions.by_name('aLwAyS')).to eq EightBall::Conditions::Always
    end
  end
end
