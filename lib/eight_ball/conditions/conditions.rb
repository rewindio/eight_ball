# frozen_string_literal: true

module EightBall::Conditions
  def self.by_name(name)
    mappings = {
      'always' => EightBall::Conditions::Always,
      'list' => EightBall::Conditions::List,
      'never' => EightBall::Conditions::Never,
      'range' => EightBall::Conditions::Range
    }
    mappings[name.downcase]
  end
end
