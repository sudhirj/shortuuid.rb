require 'shortuuid/version'

module ShortUUID
  DEFAULT_BASE62 = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze

  def self.shorten(uuid, alphabet = DEFAULT_BASE62)
    return nil unless uuid && !uuid.empty?
    decimal_value = uuid.split('-').join.to_i(16)
    convert_decimal_to_alphabet(decimal_value, alphabet)
  end

  def self.convert_decimal_to_alphabet(decimal, alphabet)
    alphabet = alphabet.to_a
    radix = alphabet.length
    i = decimal.to_i
    out = []
    loop do
      break if i == 0
      out.unshift(alphabet[i % radix])
      i /= radix
    end
    out.join
  end

  def self.convert_alphabet_to_decimal(word, alphabet)
    num = 0
    radix = alphabet.length
    word.chars.reverse.each_with_index do |char, index|
      num += alphabet.index(char) * (radix**index)
    end
    num
  end

  def self.expand(short_uuid, alphabet = DEFAULT_BASE62)
    return nil unless short_uuid && !short_uuid.empty?
    decimal_value = convert_alphabet_to_decimal(short_uuid, alphabet)
    uuid = decimal_value.to_s(16).rjust(32, '0')
    [
      uuid[0..7],
      uuid[8..11],
      uuid[12..15],
      uuid[16..19],
      uuid[20..31]
    ].join('-')
  end
end
