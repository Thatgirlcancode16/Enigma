require 'date'

class Enigma

  def initialize (message = "pizza", character_map = "")
    @offsets = nil
    @character_map = character_map
    @message = message
  end

  def get_date
    Date.today.strftime("%d%m%y")
  end

  def self.get_character_map
    [*'A'..'z', *'0'..'9', ' ', '.', ',']
  end

  def self.key_rotation(key)
    #12345
    #key.chars - > ['1', '2', '3', '4', '5']
    #key.chars.each_cons(2) -> [['1','2'], ['2','3'], ['3','4'], ['4', '5']]
    array_within_array = key.chars.each_cons(2).to_a
    arrays_joined = array_within_array.map do |array|
      array.join
    end

    final_rotations = arrays_joined.map do |num|
      num.to_i
    end

    final_rotations

  end

  def self.offset_for_date (date)
    date_as_integer = date.to_i
    date_squared = (date_as_integer ** 2).to_s
    last_four_digits_of_squared = date_squared.chars.last(4)
    last_four_digits_as_number = last_four_digits_of_squared.map do |char|
      char.to_i
    end
  end

  def offset_calculator(rotation, offsets)
    rotations_offsets = [rotation, offsets]
    @offsets = rotations_offsets.transpose.to_a.map do |element|
      element[0]+ element[1]
    end
  end

  def self.split_message_into_chunks(message)
    message.chars.each_slice(4).to_a
  end

  def chunk_rotate(type)
    chunk_array = Enigma.split_message_into_chunks(@message).map do |chunk|
      rotate_chunk chunk, type
    end
    chunk_array = chunk_array.join
  end

  def rotate_chunk(chunk, type)
    chunk.map.with_index do |char, index|
      rotate_char char, @offsets[index], type
    end
  end

  def encrypt
    chunk_rotate ("add")
  end

  def decrypt
    chunk_rotate ("subtract")
  end

  def rotate_char(character, offset, type)
    rotation = 0
    if type == "add"
      character_found_in_map = @character_map.index(character)
      if (character_found_in_map != nil)
        rotation = character_found_in_map + offset
      else
        puts "couldnt find character #{character}"
      end
    else
      rotation = @character_map.index(character) - offset
    end
    @character_map.rotate(rotation)[0]
  end
end
