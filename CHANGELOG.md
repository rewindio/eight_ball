# Changelog

## [3.0.1]

- Fix release workflow to use ruby/setup-ruby instead of actions/setup-ruby

## [3.0.0]

- Update to ruby 3.2.8
- Address deprecation warning for URI.regexp for ruby 3.2 and 3.4
- Update to bundler 2

## [2.2.1]

- Switch release to github actions

## [2.2.0]

- Add `==` to `Feature` and `Conditions`

## [2.1.0]

- Add `features` parameter to `EightBall.marshall` to allow marshalling any Features, not just the ones
   from the configured Provider.

## [2.0.0]

- [BREAKING] `Parsers` have been replaced with `Marshallers`, allowing bi-directional conversions
- Added `EightBall.marshall` as a way to output the Feature list to an external format (e.g. to create a JSON file)
- Added `EightBall.features` as a shortcut to `EightBall.provider.features`
- Testing framework has been moved from Minitest to rspec
- Updated dev dependencies

## [1.0.5]

Security: Update rake to >= 12.3.3

## [1.0.3]

Update .travis.yml

## [1.0.2]

Update .travis.yml

## [1.0.1]

Security: Update yard 0.9.16 -> 0.9.20

## [1.0.0]

Initial release!
