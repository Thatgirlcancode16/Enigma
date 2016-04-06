require './enigma'
require 'pry'
require './key_generator'

class Decrypt

input_file = ARGV[0]
encrypted_message = File.read(input_file).chomp

#get the date and key
key = ARGV[2]
date = ARGV[3]

enigma_class_variable = Enigma.new(encrypted_message, Enigma.get_character_map)

rotations = Enigma.key_rotation(key)
offset_for_date = Enigma.offset_for_date(date)
enigma_class_variable.offset_calculator(rotations, offset_for_date)
#write the output file
output_file = ARGV[1]
File.write output_file, enigma_class_variable.decrypt

#tell user it created file
puts "The file #{output_file.inspect} was created with the key #{key} and date #{date}"
end
