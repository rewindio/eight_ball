# frozen_string_literal: true

module EightBall::Conditions
  class Always < Base
    def satisfied?
      true
    end
  end
end
