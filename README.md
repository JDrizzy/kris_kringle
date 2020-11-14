# KrisKringle

Ruby library to help organise Kris Kringle.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kris_kringle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kris_kringle

## Usage

Using CSV file:
```Ruby
require "kris_kringle"

KrisKringle.sorting_hat('test.csv')
```

Using CSV data:
```Ruby
require "kris_kringle"

csv_string = CSV.generate do |csv|
    csv << %w[name partner mobile]
    csv << %w[Jarrad Rebecca 0411111111]
    csv << %w[Rebecca Jarrad 0411111112]
    ...
end

KrisKringle.sorting_hat(csv_string)
```

The following options can be passed to method `sorting_hat`:
```Ruby
KrisKringle.sorting_hat(csv, output: true, anonymous: true)
# output - determines whether any output is returned
# anonymous - outputs an object id instead of participants name so results can be confirmed as unique but the results are left unknown
```

You can also pass a block to method `sorting_hat` if you plan on processing these results in a different way:
```Ruby
# I plan on sending my results to participants via SMS
KrisKringle.sorting_hat(csv, output: true, anonymous: true) do |match|
    sms_message = "Hi #{match[:gifter].name}, you have #{match[:giftee].name} for this years Kris Kringle!"
    SMSLibrary.send(sms_message, match[:gifter].mobile)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/JDrizzy/kris_kringle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
