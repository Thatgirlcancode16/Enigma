gem 'minitest', '~> 5.2'
gem 'pry'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require './lib/key_generator'

class TestEnigma < Minitest::Test

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
  #
  # def chunk_rotate
  # end
  #
  # def rotate_chunk
  # end
  #
  def test_encyrpt
    message_to_encrypt = 'pizza'
    message_encrypted = 'sp06d'
    key = '00740'
    date = '060416'

    #instantiate classes
    enigma_class_variable = Enigma.new(message_to_encrypt, Enigma.get_character_map)

    #get rotations and date offsets
    rotations = Enigma.key_rotation(key)
    offset_for_date = Enigma.offset_for_date(date)

    #use rotations and offsets for date to get offsets
    enigma_class_variable.offset_calculator(rotations, offset_for_date)

    #encrypt and store in variable to be used in assert_equal
    encrypted_message = enigma_class_variable.encrypt

    assert_equal message_encrypted, encrypted_message
  end

  def test_decrypt
    encrypted_message = 'wedlh'
    key = '43519'
    date = '060416'
    decrypted = 'pizza'
    enigma_class_variable = Enigma.new(encrypted_message, Enigma.get_character_map)

    rotations = Enigma.key_rotation(key)
    offset_for_date = Enigma.offset_for_date(date)
    enigma_class_variable.offset_calculator(rotations, offset_for_date)

    decrypted_message = enigma_class_variable.decrypt
    assert_equal decrypted, enigma_class_variable.decrypt
  end
  #
  # def rotate_char
  # end
  #
  # def
  # end

end
