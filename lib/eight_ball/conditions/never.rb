# frozen_string_literal: true

module EightBall::Conditions
  class Never < Base
    def satisfied?
      false
    end
  end
end
