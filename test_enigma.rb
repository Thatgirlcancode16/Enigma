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
  rotation = [84, 46, 68, 85]
  offsets = [3, 0, 5, 6]
  offsets_result = [87, 46, 73, 91]
  assert_equal Enigma.offset_calculator(rotation,offsets) , offsets_result
end

# def test_self.split_message_into_chunks
# end
#
# def chunk_rotate
# end
#
# def rotate_chunk
# end
#
# def encyrpt
# end
#
# def decrypt
# end
#
# def rotate_char
# end
#
# def
# end

end
