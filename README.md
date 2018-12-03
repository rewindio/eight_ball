# EightBall

EightBall is a feature toggle querying gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eight_ball'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eight_ball

## Example Usage
```
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
```

## Concepts
### Feature
A Feature is a part of your application that can be enabled or disabled based on various conditions. It has the following attributes:
- `name`: The unique name of the Feature.
- `enabledFor`: An array of Conditions for which the Feature is enabled.
- `disabledFor`: An array of Conditions for which the Feature is disabled.

### Condition
**Supported Conditions**
- `Always`:  This condition is always satisfied.
- `List`: This condition is satisfied if the given value belongs to its list of accepted values.
- `Never`: This condition is never satisfied.
- `Range`: This condition is satisfied if the given value is within the specified range (inclusive).

### Provider
**Supported Providers**
A Provider is able to give EightBall the list of Features it needs to answer queries.
- `Static`: Once initialized with a list of Features, always provides that same list of Features.
### Parser
A Parser converts the given input to an array of Features.

**Supported Parsers**
- `JSON`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rewindio/eight_ball.
