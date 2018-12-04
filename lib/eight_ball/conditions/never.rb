# frozen_string_literal: true

module EightBall::Conditions
  # The Never Condition is never satisfied
  class Never < Base
    def satisfied?
      false
    end
  end
end
