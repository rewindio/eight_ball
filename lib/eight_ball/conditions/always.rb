# frozen_string_literal: true

module EightBall::Conditions
  # The Always Conditions is always satisfied
  class Always < Base
    def satisfied?
      true
    end
  end
end
