require './enigma'
require 'pry'
require './key_generator'

class Decrypt

  input_file = ARGV[0]
  encrypted_message = File.read(input_file).chomp

  key = ARGV[2]
  date = Date.parse(ARGV[3])

  enigma_class_variable = Enigma.new

  output_file = ARGV[1]
  File.write output_file, enigma_class_variable.decrypt(encrypted_message, key, date)

  puts "The file #{output_file.inspect} was created with the key #{key} and date #{date}"
end
