class KeyGenerator

def make_key
    rand.to_s[2..6]
  end

  def get_date
    Date.today.strftime("%d%m%y")
  end
end
