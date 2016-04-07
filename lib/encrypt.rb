require 'pry'
require './enigma'
require './key_generator'

class Encrypt

  input_file = ARGV[0]
  message_to_encrypt = File.read(input_file).chomp

  key_generator = KeyGenerator.new
  enigma_class_variable = Enigma.new
  key = key_generator.make_key
  date = Date.today
  
  output_file = ARGV[1]
  File.write output_file, enigma_class_variable.encrypt(message_to_encrypt, key)
  puts "The file #{output_file.inspect} was created with the key #{key} and date #{date}"
end
