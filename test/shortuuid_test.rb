require 'test_helper'
require 'securerandom'

class ShortUUIDTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ShortUUID::VERSION
  end

  def test_shorten
    assert_equal ShortUUID.shorten('00bb416c-5a7a-46e3-9e40-31bd76a246bb'), '1NZiG3Y1hj5wI3QRSa5UZ'
  end

  def test_expand
    assert_equal ShortUUID.expand('1NZiG3Y1hj5wI3QRSa5UZ'), '00bb416c-5a7a-46e3-9e40-31bd76a246bb'
  end

  def test_correctness
    1000.times do
      uuid = SecureRandom.uuid
      assert_equal uuid, ShortUUID.expand(ShortUUID.shorten(uuid))
    end

    alphabet = %w(a e i o u)
    1000.times do
      uuid = SecureRandom.uuid
      assert_equal uuid, ShortUUID.expand(ShortUUID.shorten(uuid, alphabet), alphabet)
    end
  end

  def test_error_handling
    assert_nil ShortUUID.expand nil
    assert_nil ShortUUID.shorten nil
    assert_nil ShortUUID.expand ''
    assert_nil ShortUUID.shorten ''
  end
end
