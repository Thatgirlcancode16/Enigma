require 'pry'
require './enigma'
require './key_generator'

class Encrypt
#class that we call methods in, not defined methods
# runner is the encrypt class

  #get message to encrypt from input file and remove any new line
  input_file = ARGV[0]
  message_to_encrypt = File.read(input_file).chomp

  #instantiate classes
  key_generator = KeyGenerator.new
  enigma_class_variable = Enigma.new(message_to_encrypt, Enigma.get_character_map)

  #get key and date
  key = key_generator.make_key
  date = key_generator.get_date

  #get rotations and date offsets
  rotations = Enigma.key_rotation(key)
  offset_for_date = Enigma.offset_for_date(date)

  #use rotations and offsets for date to get offsets
  enigma_class_variable.offset_calculator(rotations, offset_for_date)

  #encrypt and print to file
  output_file = ARGV[1]
  File.write output_file, enigma_class_variable.encrypt
  puts "The file #{output_file.inspect} was created with the key #{key} and date #{date}"
end
