gem 'minitest', '~> 5.2'
gem 'pry'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require './lib/key_generator'

class TestEnigma < Minitest::Test

  def test_key_rotation
    enigma_class_variable = Enigma.new
    test_key = "12345"
    final_rotations_array = enigma_class_variable.key_rotation(test_key)
    assert_equal [12, 23, 34, 45] ,  final_rotations_array
  end

  def test_offset
    enigma_class_variable = Enigma.new
    todays_date = "040516".to_i
    date_squared = (todays_date ** 2).to_s
    last_four_digits_of_squared = date_squared.chars.last(4)
    assert_equal last_four_digits_of_squared , enigma_class_variable.offset_for_date(todays_date)

  end

end
