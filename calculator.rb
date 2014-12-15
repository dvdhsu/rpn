class Calculator
  def self.eval(str)
    tokens = str.split(" ")
    res = tokens.reduce([]) do |stack, next_token|
      case next_token
      when "+", "-", "*", "/"
        first, second = stack.pop(2)

        # if one of them is nil, the pop failed, so incorrect number of arguments
        if !first or !second then raise ArgumentError, "incorrect number of arguments" end

        # result of applying the next_token on first, with second as argument
        # e.g. 3.send("+", 4) => 3.+(4) <= 3 + 4
        result = first.send(next_token, second)

        stack << result
      when /^\d+$/
        stack << next_token.to_num
      else
        raise TypeError, "invalid number"
      end
    end

    # unless there is one token left, we have an incorrect number of arguments
    res.count == 1 ? res.first : raise(ArgumentError, "incorrect number of arguments")
  end
end

class String
  # converts a string to an int, then disguises the int as a float
  def to_num
    accum = 0.0
    for char in self.each_char
      ascii_val = char.ord
      if ascii_val < 48 || ascii_val > 57
        # not within (0..9), so return nil
        return nil
      else
        int_val = ascii_val - 48
        accum *= 10
        accum += int_val
      end
    end
    accum
  end
end
