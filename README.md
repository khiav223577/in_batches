# in_batches

[![Gem Version](https://img.shields.io/gem/v/in_batches.svg?style=flat)](https://rubygems.org/gems/in_batches)
[![Build Status](https://api.travis-ci.com/khiav223577/in_batches/workflows/Ruby/badge.svg)](https://travis-ci.com/khiav223577/in_batches/actions)
[![RubyGems](http://img.shields.io/gem/dt/in_batches.svg?style=flat)](https://rubygems.org/gems/in_batches)
[![Code Climate](https://codeclimate.com/github/khiav223577/in_batches/badges/gpa.svg)](https://codeclimate.com/github/khiav223577/in_batches)
[![Test Coverage](https://codeclimate.com/github/khiav223577/in_batches/badges/coverage.svg)](https://codeclimate.com/github/khiav223577/in_batches/coverage)

Backport `in_batches` from Rails 5 for Rails 3 and 4.

## Supports
- Ruby 2.2 ~ 2.7
- Rails 3.2, 4.2, 5.0, 5.1, 5.2, 6.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'in_batches'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install in_batches
    
## Usage

Same as Rails 5's #in_batches method.

### update in batches
```rb
User.in_batches.update_all('money = money + 1')
```

### delete in batches and throttle the delete queries
```rb
User.where("age > 21").in_batches do |users|
  users.delete_all
  sleep(10)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khiav223577/in_batches. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

