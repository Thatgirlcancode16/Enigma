require 'pry'
require_relative 'key_generator'
class Encrypt
#class that we call methods in, not defined methods
# runner is the encrypt class

  key_generator = KeyGenerator.new
  enigma_class_variable = Enigma.new

  key = key_generator.make_key

  rotations = enigma_class_variable.key_rotation(key)

  date = key_generator.get_date

  offset_calculator = OffsetCalculator.new



end
