class Decrypt

key = '84547'
encrypted_message = 'yogaj'

key_generator = KeyGenerator.new

key = key_generator.make_key
date = key_generator.get_date
character_map = [*'a'..'z', *'0'..'9', ' ', '.', ','];

enigma_class_variable = Enigma.new(encrypted_message, character_map)

rotations = enigma_class_variable.key_rotation(key)
offset_for_date = enigma_class_variable.offset_for_date(date)

enigma_class_variable.offset_calculator(rotations, offset_for_date)
puts enigma.decrypt
end
