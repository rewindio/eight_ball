# frozen_string_literal: true

RSpec.describe EightBall::Feature do
  describe 'enabled?' do
    it 'should return true if no conditions' do
      feature = EightBall::Feature.new 'NoConditions'
      expect(feature.enabled?).to be true
    end

    it 'should return true if one of the enabled_for conditions is satisfied' do
      satisfied = EightBall::Conditions::Always.new
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [satisfied, unsatisfied]
      expect(feature.enabled?).to be true
    end

    it 'should return true if all of the enabled_for conditions are satisfied' do
      satisfied1 = EightBall::Conditions::Always.new
      satisfied2 = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', [satisfied1, satisfied2]
      expect(feature.enabled?).to be true
    end

    it 'should return false if none of the enabled_for conditions are satisfied' do
      unsatisfied1 = EightBall::Conditions::Never.new
      unsatisfied2 = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [unsatisfied1, unsatisfied2]
      expect(feature.enabled?).to be false
    end

    it 'should return true if enabled_for satisfied and disabled_for not satisfied' do
      satisfied = EightBall::Conditions::Always.new
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', [satisfied], [unsatisfied]
      expect(feature.enabled?).to be true
    end

    it 'should return false if no enabled_for provided and disabled_for is satisfied' do
      satisfied = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', nil, [satisfied]
      expect(feature.enabled?).to be false
    end

    it 'should return true if no enabled_for provided and disabled_for is not satisfied' do
      unsatisfied = EightBall::Conditions::Never.new

      feature = EightBall::Feature.new 'Feature', nil, [unsatisfied]
      expect(feature.enabled?).to be true
    end

    it 'should return false if enabled_for is satisfied and disabled_for is satisfied' do
      satisfied1 = EightBall::Conditions::Always.new
      satisfied2 = EightBall::Conditions::Always.new

      feature = EightBall::Feature.new 'Feature', [satisfied1], [satisfied2]
      expect(feature.enabled?).to be false
    end

    it 'should raise an Exception if a parameter is missing' do
      condition = EightBall::Conditions::List.new parameter: 'param1', values: [1, 2]
      feature = EightBall::Feature.new 'Feature', condition

      expect { feature.enabled? }.to raise_error ArgumentError, 'Missing parameter param1'
    end

    it 'should pass parameter to satisfied?' do
      condition = EightBall::Conditions::List.new parameter: 'param1', values: [1, 2]

      expect(condition).to receive(:satisfied?).with 1

      feature = EightBall::Feature.new 'Feature', condition
      feature.enabled? param1: 1
    end
  end

  describe '==' do
    it 'should return false if the names do not match' do
      f1 = EightBall::Feature.new 'name1'
      f2 = EightBall::Feature.new 'name2'

      expect(f1 == f2).to be false
    end

    it 'should return false if the number of "enabled for" conditions differ' do
      f1 = EightBall::Feature.new 'name1', [EightBall::Conditions::Always.new, EightBall::Conditions::Always.new]
      f2 = EightBall::Feature.new 'name1', [EightBall::Conditions::Always.new]

      expect(f1 == f2).to be false
    end

    it 'should return false if the number of "disabled for" conditions differ' do
      f1 = EightBall::Feature.new 'name1', [], [EightBall::Conditions::Always.new, EightBall::Conditions::Always.new]
      f2 = EightBall::Feature.new 'name1', [], [EightBall::Conditions::Always.new]

      expect(f1 == f2).to be false
    end

    it 'should return true if every "enabled for" condition is matched, regardless of order' do
      f1 = EightBall::Feature.new('name1', [
        EightBall::Conditions::Range.new(min: 1, max: 2),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])
      f2 = EightBall::Feature.new('name1', [
        EightBall::Conditions::List.new(values: [1, 2, 3]),
        EightBall::Conditions::Range.new(min: 1, max: 2)
      ])

      expect(f1 == f2).to be true
    end

    it 'should return false if a single "enabled for" condition is not matched' do
      f1 = EightBall::Feature.new('name1', [
        EightBall::Conditions::Range.new(min: 1, max: 2),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])
      f2 = EightBall::Feature.new('name1', [
        EightBall::Conditions::Range.new(min: 3, max: 4),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])

      expect(f1 == f2).to be false
    end

    it 'should return true if every "disabled for" condition is matched, regardless of order' do
      f1 = EightBall::Feature.new('name1', [], [
        EightBall::Conditions::Range.new(min: 1, max: 2),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])
      f2 = EightBall::Feature.new('name1', [], [
        EightBall::Conditions::List.new(values: [1, 2, 3]),
        EightBall::Conditions::Range.new(min: 1, max: 2)
      ])

      expect(f1 == f2).to be true
    end

    it 'should return false if a single "disabled for" condition is not matched' do
      f1 = EightBall::Feature.new('name1', [], [
        EightBall::Conditions::Range.new(min: 1, max: 2),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])
      f2 = EightBall::Feature.new('name1', [], [
        EightBall::Conditions::Range.new(min: 3, max: 4),
        EightBall::Conditions::List.new(values: [1, 2, 3])
      ])

      expect(f1 == f2).to be false
    end
  end
end
