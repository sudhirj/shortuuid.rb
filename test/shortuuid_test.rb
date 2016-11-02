require 'test_helper'
require 'securerandom'

class ShortUUIDTest < Minitest::Test
  EXAMPLES = { '4f77f8d9-1c48-46d7-b477-693c2168a63a' => '2PxDiMQ6GcdX2gWH9uxQGg',
               '53a8d1b9-4eca-4888-9b59-8fa91497857b' => '2XrVqpuNYMfp5OSuawGnL1',
               '9dff78bd-25bf-48a7-b962-47121e2f8abb' => '4o8XraygEz74U5VcWAHfb9',
               '97ed0539-f38e-4851-9ea1-2c420b9e3c8e' => '4cg9v4IOwgEgAjQXVl2aiM',
               'e371489d-8cf9-4612-8bcb-ba6e7bcb6da2' => '6vB1nTe4C1jJ3R7e5M0ETa',
               '2e5b029c-bae4-4b4b-8265-699d911d2c42' => '1PTEo1hMaUFibCywjsRLIg',
               'e9360b9a-9b0c-442e-9f41-70a1cb2e92b1' => '763uTm4g8wSb9ojuPwYwSH',
               '08f057f3-23e0-4b2a-8703-03f2dab8f628' => 'Grm6f7QVJVuVrufEOTgIC',
               'bd7da66f-0473-4f0b-b22b-13e50e091188' => '5lYyGdkeeGhhagAO34mMO0',
               'df540be5-e504-4c72-9ef9-17ecbfd4886d' => '6nPhI89QMDrD1iQr7xEX9R',
               '54027bef-34b4-433e-92e8-bd250718d819' => '2YWUQIU5tlKQqT5qbsw7ZJ',
               '8658bb57-992d-4a4d-9292-a5b118d28c8b' => '45VWNy74cXYBydTM0JO3rv',
               'a7dcc285-16ec-4b0a-af1a-3658a15ed6d1' => '56kbZzRtV2g7yYf4G97VUv',
               '607a4a5e-28cb-48e4-892a-8f09d52c1a0c' => '2w39JluOCmuC3CnE34ReI8',
               'd26abc73-a6bf-49c6-984d-e08c941fad4a' => '6P3AMn3h7r9JJSeHECCjJS',
               '5b109229-b3d8-4623-bf69-5d71ed611db4' => '2lpsELdUhx0S8wiem4mMq4',
               '788e6389-ff1c-4b43-86b2-0ae92292c62c' => '3fU9MsSs7HFv9LWe6BX50m',
               '62263f37-9ef1-49ba-9790-d29edcb20f4a' => '2zCj4Ne1tBbZaiZlHG7XOE',
               'eaf186de-b255-42bf-8046-288e286e5799' => '79Ka7SqpMzbYobZdnAA1Cz',
               '1d152c86-c436-4d47-9269-006c7469b867' => 'ssS9A1oUhTFAbdjd6w93P' }.freeze

  def test_that_it_has_a_version_number
    refute_nil ::ShortUUID::VERSION
  end

  def test_shorten
    EXAMPLES.each do |key, value|
      assert_equal ShortUUID.shorten(key), value
    end
  end

  def test_expand
    EXAMPLES.each do |key, value|
      assert_equal ShortUUID.expand(value), key
    end
  end

  def test_custom_alphabet
    alphabet = %w(a e i o u)
    custom_examples = { '4f77f8d9-1c48-46d7-b477-693c2168a63a' =>
                          'euiiueioooiouuuueoeouooeiouaueieaeuiaoaeaiaeeuaoeeioeoo',
                        '53a8d1b9-4eca-4888-9b59-8fa91497857b' =>
                          'iaaaiaaoiuiooeuoaooeouaiaiuaiooioaaieuioiuiuuiiiiaioaee',
                        '9dff78bd-25bf-48a7-b962-47121e2f8abb' =>
                          'oouiuiuaeaoouaiiaaaaoouaiuiueoeoaeieeaaeuuuuaoeoiuooioi' }
    custom_examples.each do |key, value|
      assert_equal ShortUUID.shorten(key, alphabet), value
      assert_equal ShortUUID.expand(value, alphabet), key
    end
  end

  def test_reversal
    assert_equal 0, ShortUUID.convert_alphabet_to_decimal('0', %w(0 1 2))
    assert_equal 1, ShortUUID.convert_alphabet_to_decimal('1', %w(0 1 2))
    assert_equal 2, ShortUUID.convert_alphabet_to_decimal('2', %w(0 1 2))
    assert_equal 3, ShortUUID.convert_alphabet_to_decimal('10', %w(0 1 2))
    assert_equal 4, ShortUUID.convert_alphabet_to_decimal('11', %w(0 1 2))
    assert_equal 5, ShortUUID.convert_alphabet_to_decimal('12', %w(0 1 2))
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
