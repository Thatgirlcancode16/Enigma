gem 'minitest', '~> 5.2'
gem 'pry'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require './lib/key_generator'

class TestEnigma < Minitest::Test

  def test_character_map
    map = Enigma.get_character_map
    assert_equal 71, map.length
    assert_equal [*'A'..'z', *'0'..'9', ' ', '.', ','], map
  end

  def test_key_rotation
    test_key = "12345"
    final_rotations_array = Enigma.key_rotation(test_key)
    assert_equal [12, 23, 34, 45] ,  final_rotations_array
  end

  def test_offset_for_date
    todays_date = "040516".to_i
    date_squared = (todays_date ** 2).to_s
    last_four_digits_of_squared = date_squared.chars.last(4).map do |number|
      number.to_i
    end
    assert_equal last_four_digits_of_squared , Enigma.offset_for_date(todays_date)
  end

  def test_offset_calculator
    enigma = Enigma.new
    rotation = [84, 46, 68, 85]
    offsets = [3, 0, 5, 6]
    offsets_result = [87, 46, 73, 91]
    assert_equal enigma.offset_calculator(rotation,offsets) , offsets_result
  end

  def test_self_split_message_into_chunks
    message = "pizza"
    assert_equal [["p", "i", "z", "z"], ["a"]], Enigma.split_message_into_chunks(message)
  end

  def test_chunk_rotate
    enigma_class_variable = Enigma.new("pizza", Enigma.get_character_map)
    enigma_class_variable.offsets = [74, 18, 90, 59]
    assert_equal "s0Fnd" , enigma_class_variable.chunk_rotate("add")
  end

  def test_rotate_chunk
    enigma_class_variable = Enigma.new("pizza", Enigma.get_character_map)
    enigma_class_variable.offsets = [89, 66, 65, 8]
    chunk = ["p", "i", "z", "z"]
    type = "add"
    expected_rotation = ["7", "d", "t", "7"]
    assert_equal expected_rotation, enigma_class_variable.rotate_chunk(chunk, type)
  end

  def test_rotate_char
    enigma_class_variable = Enigma.new("pizza", Enigma.get_character_map)
    character = "p"
    offset = 11
    type = "add"
    rotated_character = '0'
    assert_equal rotated_character, enigma_class_variable.rotate_char(character, offset, type)
  end

  def test_encyrpt
    message_to_encrypt = 'pizza'
    expected_encryption = 'sp7ad'
    key = '00740'
    date = Date.parse("2016-04-06")

    enigma_class_variable = Enigma.new
    encrypted_message = enigma_class_variable.encrypt(message_to_encrypt, key, date)
    assert_equal expected_encryption, encrypted_message
  end

  def test_decrypt
    encrypted_message = 'wedlh'
    key = '43519'
    date = Date.parse("2016-04-06")
    decrypted_expected = 'IBsS6'
    enigma_class_variable = Enigma.new
    decrypted_message = enigma_class_variable.decrypt(encrypted_message, key, date)
    assert_equal decrypted_expected, decrypted_message
  end

  def test_short_encrypt
    e = Enigma.new
    output = e.encrypt("pizza", "12345", Date.parse("2016-04-06"))
    assert_equal "45Zfp", output
  end

  def test_short_decrypt
    e = Enigma.new
    output = e.encrypt("pizza", "12345", Date.parse("2016-04-06"))
    unencrypted = e.decrypt(output, "12345", Date.parse("2016-04-06"))
    assert_equal "pizza", unencrypted
  end
end
