class Enigma

  def key_rotation(key)
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

  def offset_for_date (date)
    date_as_integer = date.to_i
    date_squared = (date_as_integer ** 2).to_s
    last_four_digits_of_squared = date_squared.chars.last(4)
  end

def offset_calculator

end












end
