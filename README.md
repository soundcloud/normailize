# Normailize

> **Important notice**: We decided to discontinue support for this project; SoundCloud will no longer accept pull requests or publish new releases. If you're using normailize in one of your projects, we suggest you fork the project in order to perform any necessary maintenance.

Normailize is a gem to normalize email addresses from something like `Jo.Hn+sneaky@gmail.com` to `john@gmail.com`. This can be used in applications to prevent
spammers and other shady types from signing up multiple times with variations of the same email address by adding dots, mixing the case or adding a plus sign
followed by an arbitrary string.

Normailize currently supports normalizations for the following providers:

 - gmail.com (including googlemail.com)
 - live.com
 - hotmail.com

If an email is given that is not from any of the known providers, it will not do any normalization and only make a simple comparison between two addresses.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'normailize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install normailize

## Usage

### Comparing two email addresses

The core of the gem is the `Normailize::EmailAddress#same_as?` which can compare two email addresses and returns true if they normalize into the same address:

```ruby
# Lets compare two Gmail addresses:

address1 = Normailize::EmailAddress.new('Jo.Hn+sneaky@gmail.com')
address2 = Normailize::EmailAddress.new('j.o.h.n+again@googlemail.com')

address1.same_as?(address2) # => True, they both normalize to john and gmail.com and googlemail.com are domains for the same provider

# Now we compare two live.com addresses:

address1 = Normailize::EmailAddress.new('john@live.com')
address2 = Normailize::EmailAddress.new('john+sneaky@live.com')

address1.same_as?(address2) # => True, they both normalize to john@live.com

# These are not the same addresses:

address1 = Normailize::EmailAddress.new('john@somewhere.com')
address2 = Normailize::EmailAddress.new('john@somewhereelse.com')

address1.same_as?(address2) # => False, they are not the same addresses
```

### Getting the normalized email address

If you want to get the normalized email address, you can call the `Normailize::EmailAddress#normalized_address` method:

```ruby
address = Normailize::EmailAddress.new('J.oh.N+sNeaky@gmail.com')
address.normalized_address # => john@gmail.com
```

### Adding a new provider

If you want to normalize addresses from providers that are not already covered, it's fairly easy to add a new one:

#### Adding a new provider class

The following is a basic provider for somewhere.com:

```ruby
module Normailize
  module Provider
    class Somewhere
      include Normailize::Provider

      # Specify one or more domains for somewhere.com
      set_domains 'somewhere.com'

      # Specify modificiations to be done on the username part of the email.
      # The following modificiations are currently supported:
      #   - :lowercase          Lowercases the username
      #   - :remove_dots        Removes all dots
      #   - :remove_plus_part   Removes everything after the first occurrence of a plus sign
      set_modifications :lowercase, :remove_plus_part
    end
  end
end
```

Adapt the Somewhere provider to fit the new provider and save it in the `lib/normailize/providers` directory

#### Registering the new provider

Open `lib/normailize/provider.rb` and add a switch case in the `Normailize::Provider#factory` method

This is not perfect and will probably change in the future.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
