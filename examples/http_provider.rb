require 'eight_ball'

# Tell EightBall about the Features
EightBall.provider = EightBall::Providers::Http.new '<YOUR URL HERE>'

# Away you go
EightBall.enabled? 'Feature1', account_id: 4 # true
EightBall.enabled? 'Feature1', account_id: 2 # false
