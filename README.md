# ShortUUID

Encode and decode UUIDs into any alphabet. Can either be used to improve space efficiency by using any alphabet with more than 16 characters, or any other alphabet for fun or profit.

The default alphabet is a URL safe base62, as defined by

`DEFAULT_BASE62 = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze`

## Usage

```
irb(main):001:0> id = SecureRandom.uuid
=> "4890586e-32a5-4f9c-a000-2a2bb68eb1ce"

irb(main):003:0> short_id = ShortUUID.shorten id
=> "2CvPdpytrcURpSLoPxYb30"

irb(main):005:0> ShortUUID.expand short_id
=> "4890586e-32a5-4f9c-a000-2a2bb68eb1ce"

irb(main):007:0> vowel_id = ShortUUID.shorten id, "AEIOU".chars
=> "EOOIAUUEOUUIOIIEUUUAOOUIOOUUAOIIIEAUAOUAAAOEOOEOAUAUUEE"

irb(main):009:0> ShortUUID.expand vowel_id, "AEIOU".chars
=> "4890586e-32a5-4f9c-a000-2a2bb68eb1ce"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shortuuid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shortuuid


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sudhirj/shortuuid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

