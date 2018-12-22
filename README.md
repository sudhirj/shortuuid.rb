# ShortUUID

Encode and decode UUIDs into any alphabet. Can either be used to improve space efficiency by using any alphabet with more than 16 characters, or any other alphabet for fun or profit.

The default alphabet is a URL safe base62, as defined by

`DEFAULT_BASE62 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'`

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

ShortUUID also works for numerical IDs: 

```
irb(main):006:0> t = Time.now.to_i
=> 1545502666
irb(main):007:0> ShortUUID.encode t
=> "1galqM"

irb(main):008:0> t2 = Time.now.to_i
=> 1545502688
irb(main):009:0> ShortUUID.encode t2
=> "1galqi"

irb(main):010:0> t < t2
=> true
irb(main):011:0> ShortUUID.encode(t) < ShortUUID.encode(t2)
=> true
```
And the default alphabet is lexicographically sortable, if the encoded strings are the same length:
```
irb(main):013:0> a = 42
=> 42
irb(main):014:0> b = rand(9999999999999999)
=> 6674476916560393
irb(main):015:0> a < b
=> true
irb(main):016:0> ShortUUID.encode(a) < ShortUUID.encode(b)
=> false
irb(main):018:0> ShortUUID.encode(a).rjust(10, '0') < ShortUUID.encode(b).rjust(10, '0')
=> true
irb(main):021:0> [a, b].map{|x| ShortUUID::encode(x)}
=> ["g", "UZHuMM7pZ"]
irb(main):022:0> [a, b].map{|x| ShortUUID::encode(x).rjust(10, '0')}
=> ["000000000g", "0UZHuMM7pZ"]
irb(main):023:0> 
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

