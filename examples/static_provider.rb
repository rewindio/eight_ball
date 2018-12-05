require 'eight_ball'

# Create a Feature programatically
enabled_for = EightBall::Conditions::Range.new min: 1, max: 10, parameter: 'account_id'
disabled_for = EightBall::Conditions::List.new values: [2, 3]
feature = EightBall::Feature.new 'Feature1', enabled_for, disabled_for

# Tell EightBall about the Features
EightBall.provider = EightBall::Providers::Static.new feature

# Away you go
EightBall.enabled? 'Feature1', account_id: 4 # true
EightBall.enabled? 'Feature1', account_id: 2 # false
