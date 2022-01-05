# frozen_string_literal: true

require 'shortuuid/version'

module ShortUUID
  DEFAULT_BASE62 = %w[0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze
  DOUGLAS_CROCKFORD_BASE32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ".chars.freeze
  HYPHEN = "-".freeze

  class << self
    attr_accessor :default_alphabet
  end
  self.default_alphabet = DEFAULT_BASE62

  def self.shorten(uuid, alphabet = default_alphabet, **options)
    return nil unless uuid && !uuid.empty?
    decimal_value = uuid.split(HYPHEN).join.to_i(16)
    convert_decimal_to_alphabet(decimal_value, alphabet, **options)
  end

  def self.convert_decimal_to_alphabet(decimal, alphabet = default_alphabet, **options)
    alphabet = alphabet.to_a
    radix = alphabet.length
    i = decimal.to_i
    out = []
    return alphabet[0] if i.zero?
    loop do
      break if i.zero?
      out.unshift(alphabet[i % radix])
      i /= radix
    end
    str = out.join
    
    str = str.scan(/.{1,#{options[:split]}}/).join(HYPHEN) if options[:split]

    str
  end

  def self.convert_alphabet_to_decimal(word, alphabet = default_alphabet)
    word = word.gsub(HYPHEN, '') unless alphabet.include?(HYPHEN)
    num = 0
    radix = alphabet.length
    word.chars.to_a.reverse.each_with_index do |char, index|
      num += alphabet.index(char) * (radix**index)
    end
    num
  end

  def self.encode(number, alphabet = default_alphabet)
    convert_decimal_to_alphabet(number, alphabet)
  end

  def self.decode(word, alphabet = default_alphabet)
    convert_alphabet_to_decimal(word, alphabet)
  end

  def self.expand(short_uuid, alphabet = default_alphabet)
    return nil unless short_uuid && !short_uuid.empty?
    decimal_value = convert_alphabet_to_decimal(short_uuid, alphabet)
    uuid = decimal_value.to_s(16).rjust(32, '0')
    [
      uuid[0..7],
      uuid[8..11],
      uuid[12..15],
      uuid[16..19],
      uuid[20..31]
    ].join(HYPHEN)
  end
end
