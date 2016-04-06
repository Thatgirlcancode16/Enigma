require 'pry'
require './enigma'
require './key_generator'

class Encrypt
#class that we call methods in, not defined methods
# runner is the encrypt class

  key_generator = KeyGenerator.new

  message_to_encrypt = "pizza"
  key = key_generator.make_key
  date = key_generator.get_date
  character_map = [*'a'..'z', *'0'..'9', ' ', '.', ','];

  enigma_class_variable = Enigma.new(message_to_encrypt, character_map)

  rotations = Enigma.key_rotation(key)
  offset_for_date = Enigma.offset_for_date(date)

  Enigma.offset_calculator(rotations, offset_for_date)
  binding.pry
  puts "original message: #{message_to_encrypt}"
  puts "Encryped version: #{enigma_class_variable.encrypt}"
  puts "key #{key}"


end
