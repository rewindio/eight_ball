require 'eight_ball'

# This could be read from the filesystem or be the response from an external service, etc.
json_input = %(
  [{
    "name": "Feature1",
    "enabledFor": [{
      "type": "range",
      "parameter": "accountId",
      "min": 1,
      "max": 10
    }],
    "disabledFor": [{
      "type": "list",
      "parameter": "accountId",
      "values": [2, 3]
    }]
  }]
)

# Transform the JSON into a list of Features
parser = EightBall::Parsers::Json.new
features = parser.parse json_input

# Tell EightBall about these Features
EightBall.provider = EightBall::Providers::Static.new features

# Away you go
EightBall.enabled? "Feature1", { accountId: 4 } # true
EightBall.enabled? "Feature1", { accountId: 2 } # false
