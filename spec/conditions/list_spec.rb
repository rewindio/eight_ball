# frozen_string_literal: true

RSpec.describe EightBall::Conditions::List do
  describe 'initialize' do
    it 'should ensure values is an array' do
      expect(EightBall::Conditions::List.new(values: 1).values).to eq [1]
      expect(EightBall::Conditions::List.new(values: nil).values).to eq []
      expect(EightBall::Conditions::List.new(nil).values).to eq []
      expect(EightBall::Conditions::List.new.values).to eq []
      expect(EightBall::Conditions::List.new(values: 'a').values).to eq ['a']
      expect(EightBall::Conditions::List.new(values: []).values).to eq []
    end

    it 'should set parameter' do
      expect(EightBall::Conditions::List.new(parameter: 'a').parameter).to eq 'a'
    end
  end

  describe 'satifisfied?' do
    it 'should return true if value accepted' do
      list1 = EightBall::Conditions::List.new values: [1, 2, 3]
      expect(list1.satisfied?(1)).to eq true

      list2 = EightBall::Conditions::List.new values: %w[John Jim]
      expect(list2.satisfied?('John')).to eq true
    end

    it 'should return false if value not accepted' do
      list1 = EightBall::Conditions::List.new values: [1, 2, 3]
      expect(list1.satisfied?(4)).to eq false

      list2 = EightBall::Conditions::List.new values: %w[John Jim]
      expect(list2.satisfied?('Jeremy')).to eq false
    end
  end
end
