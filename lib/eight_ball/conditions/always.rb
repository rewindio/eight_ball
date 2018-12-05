# frozen_string_literal: true

module EightBall::Conditions
  # The Always Condition is always satisfied
  class Always < Base
    def satisfied?
      true
    end
  end
end
